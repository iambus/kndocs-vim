

""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""

function! JustifyTo(s, n)
	if a:s =~ '^\s*$'
		return ''
	endif
	if a:s =~ '^\S*$'
		return a:s
	endif

	let m = a:n - strlen(a:s)
	if m <= 0
		return a:s
	endif
	let sm = repeat(" ", m)

	let ss = " "
	while a:s =~ (ss . " ")
		let ss = ss . " "
	endwhile
	let end = matchend(a:s, '.*' . ss)
	let s1 = strpart(a:s, 0, end)
	let s2 = strpart(a:s, end)

	return s1 . sm . s2
endfunction

function! AlignBoth() range
	let begin = line("'<")
	let end = line("'>")
	let n = begin
	let m = 0
	while (n <= end)
		let s = substitute(getline(n), '^\s*\|\s*$', '', 'g')
		let s = tr(s, "\t", " ")
		call setline(n, s)
		let l = strlen(s)
		if m < l
			let m = l
		endif
		let n = n + 1
	endwhile

	if exists("g:a4_width")
		let m = g:a4_width
	endif

	let n = begin
	while (n <= end)
		let s = getline(n)
		let s = JustifyTo(s, m)
		call setline(n, s)
		let n = n + 1
	endwhile

endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""

function! JustifyBlock(s, a, b, t)
	let s1 = strpart(a:s, 0, a:a)
	let s2 = strpart(a:s, a:a, a:b - a:a)
	let s3 = strpart(a:s, a:b)
	let s = substitute(s2, '^\s*\|\s*$', '', 'g')
	let n = a:b - a:a
	let m = n - strlen(s)

	if a:t == 1
		let s = s . repeat(" ", m)
	elseif a:t == 2
		let s = repeat(" ", m/2) . s . repeat(" ", m/2 + m%2)
	elseif a:t == 3
		let s = repeat(" ", m) . s
	else
		s = s2
	endif

	return substitute(s1 . s . s3, '\s*$', '', '')
endfunction

function! AlignBlock(t) range
	let begin = line("'<")
	let end = line("'>")
	let left = col("'<") - 1
	let right = col("'>") - 1
	if left > right
		let t = left
		let left = right
		let right = t
	endif

	let n = begin
	while (n <= end)
		let line = getline(n)
		call setline(n, JustifyBlock(line, left, right, a:t))
		let n = n + 1
	endwhile

endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""

function! BulletList()
    let lineno = line(".")
    call setline(lineno, "* " . getline(lineno))
endfunction

function! NumberList() range
  " set line numbers in front of lines
  let beginning=line("'<")
  let ending= line("'>")
  let difsize = ending-beginning + 1
  let pre = ''
  while (beginning <= ending)
      if match(difsize, '^9*$') == 0
          let pre = pre . ' '
      endif
    call setline(ending, pre . difsize . ". " . getline(ending))
    let ending=ending-1
    let difsize=difsize-1
  endwhile
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""

map \bul :call BulletList()<cr>
map \num :call NumberList()<cr>

map \h1 yypVr=o
map \h2 yypVr-o
map \h3 :s/\(.\+\)/-\1-/<cr>:noh<cr>o

function! SelectAlign(t)
	if a:t == 1
		if visualmode() == "\x16"
			call AlignBlock(1)
		else
			left
		endif
	elseif a:t == 2
		if visualmode() == "\x16"
			call AlignBlock(2)
		else
			center
		endif
	elseif a:t == 3
		if visualmode() == "\x16"
			call AlignBlock(3)
		else
			right
		endif
	elseif a:t == 4
		call AlignBoth()
	endif
endfunction
map <silent> \a1 :call SelectAlign(1)<cr>
map <silent> \a2 :call SelectAlign(2)<cr>
map <silent> \a3 :call SelectAlign(3)<cr>
map <silent> \a4 :call SelectAlign(4)<cr>





