

function! Platform()
  if has('win32')
    return "win"
  elseif has('win64')
    return "win"
  elseif has('linux')
    return 'linux'
  else
    throw 'Unknown platform'
    return 'unkown'
  endif
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""
" Basic
""""""""""""""""""""""""""""""""""""""""""""""""""

" Generl
set nobackup
set number
set ignorecase
set incsearch
set vb t_vb=

" Mappings
let mapleader = ","

map <leader>W :cd F:/temp<cr>:w! _<cr>
"map <leader>S :source $VIM/_vimrc<cr>
map <leader>cd :cd %:p:h<cr>
map \rc :e $VIM/_vimrc<cr>
map \lrc :e $VIM/local_vimrc<cr>
map \sorc :source $VIM/_vimrc<cr>
map \slrc :source $VIM/local_vimrc<cr>
map \r$ :%s/\r$//<cr>

set winaltkeys=no
map <M-y> "+yy
map <M-Y> gg"+yG<C-O><C-O>
noremap <M-a> <C-a>
noremap <M-v> <C-v>
noremap <M-x> <C-x>


" Indent
set tabstop=4
set shiftwidth=4
"set expandtab
"set smarttab

map <leader>t2 :set expandtab<cr>:set shiftwidth=2<cr>
map <leader>t3 :set expandtab<cr>:set shiftwidth=3<cr>
map <leader>t4 :set expandtab<cr>:set shiftwidth=4<cr>
map <leader>tt :set noexpandtab<cr>:set shiftwidth=4<cr>

" File format
set ffs=dos,unix,mac
nmap <leader>fd :set ff=dos<cr>
nmap <leader>fD :set ffs=dos<cr>:e<cr>
"nmap <leader>fD :e ++ff=dos<cr>
nmap <leader>fu :set ff=unix<cr>
nmap <leader>fm :set ff=mac<cr>
autocmd FileType sh set ff=unix " XXX: does it have any potential problem?

" File encoding
set fileencodings=ucs-bom,utf-8


" Look
if has("gui_running")
	let psc_style='cool'
	colorscheme ps_color
"	colorscheme desert
	set guifont=Monaco:h10:cDEFAULT
	set guioptions-=T
else
	set background=dark
	colorscheme zellner
endif
"set laststatus=2
set statusline=\ %<%F%m%r%h\ %w\ \ [%{&ff}][%{&fenc!=''?&fenc:&enc}%{&bomb?',BOM':''}][%Y]\ %=%4l,%-10.(%c%V%)\ %P\ 



""""""""""""""""""""""""""""""""""""""""""""""""""
" Folding
""""""""""""""""""""""""""""""""""""""""""""""""""
" All removed...


""""""""""""""""""""""""""""""""""""""""""""""""""
" Tab mappings
""""""""""""""""""""""""""""""""""""""""""""""""""
map <M-1> 1gt
map <M-2> 2gt
map <M-3> 3gt
map <M-4> 4gt
map <M-5> 5gt
map <M-6> 6gt
map <M-7> 7gt
map <M-8> 8gt
map <M-9> 9gt
map <M-0> :tablast<cr>
map <M-n> gt
map <M-p> gT
map <M-t> :tabnew<cr>
map <M-w> :tabclose<cr>
map <M-h> :tab help<cr>
map! <M-1> <esc>1gt
map! <M-2> <esc>2gt
map! <M-3> <esc>3gt
map! <M-4> <esc>4gt
map! <M-5> <esc>5gt
map! <M-6> <esc>6gt
map! <M-7> <esc>7gt
map! <M-8> <esc>8gt
map! <M-9> <esc>9gt
map! <M-0> <esc>:tablast<cr>
map! <M-n> <esc>gt
map! <M-p> <esc>gT
map! <M-t> <esc>:tabnew<cr>
map! <M-w> <esc>:tabclose<cr>
map! <M-h> <esc>:tab help<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""
" Diff between tabs
""""""""""""""""""""""""""""""""""""""""""""""""""

function! DiffFiles(f1, f2)
	execute 'tablast'
	execute 'tabnew ' . a:f2
	execute 'vertical diffsplit ' . a:f1
endfunction

function! DiffTabs(t1, t2)
	function! GetTabFile(n)
		let buflist = tabpagebuflist(a:n)
		let winnr = tabpagewinnr(a:n)
		return bufname(buflist[winnr - 1])
	endfunction
	let s1 = GetTabFile(a:t1)
	let s2 = GetTabFile(a:t2)
	call DiffFiles(s1, s2)
endfunction

function! DiffEndTabs()
	let n = tabpagenr('$')
	call DiffTabs(n-1, n)
endfunction

map <silent> \diff :call DiffTabs(1, 2)<cr>
map <silent> \dif0 :call DiffEndTabs()<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""
" M-x for vim
""""""""""""""""""""""""""""""""""""""""""""""""""

let s:mxdict = {}

function! MXInput()
	call inputsave()
	let cmd = input("M-x ","","customlist,CommandList")
	call inputrestore()
	if cmd != ""
		call MX(cmd)
	endif
endfunction

function! MX(cmd)
	let cmd = a:cmd

	if HasCommand(cmd)
		let x = GetCommand(cmd)
		execute 'normal ' . x
	elseif maparg('\' . cmd) != ""
		execute 'normal ' . '\' . cmd
	elseif maparg(',' . cmd) != ""
		execute 'normal ' . ',' . cmd
	endif
endfunction

function! PutCommand(name, seq)
	let s:mxdict[a:name] = a:seq
endfunction

function! GetCommand(name)
	return s:mxdict[a:name]
endfunction

function! HasCommand(name)
	return has_key(s:mxdict, a:name)
endfunction

map <M-x> :call MXInput()<cr>

function! CommandList(ArgLead, CmdLine, CursorPos)
	let list = GetCommandList()
	let nlist = []
	for i in list
		if stridx(tolower(i), tolower(a:CmdLine)) == 0
			call add(nlist, i)
		endif
	endfor
	return nlist
endfunction

function! GetCommandList()
	return sort(keys(s:mxdict), 1)
endfunction

command! -nargs=* Command call PutCommand(<f-args>)


Command copy-all gg"+yG``
Command TOHtmlForOutlook \print
Command open-browser \openwd
Command open-command \opencd
Command only \only
Command remove-bom \nobom
Command hitest \hitest

map \temp1 :w! F:/temp/_1<cr>
map \temp2 :w! F:/temp/_2<cr>
map \temp3 :w! F:/temp/_3<cr>
map \temp4 :w! F:/temp/_4<cr>
map \temp5 :w! F:/temp/_5<cr>
map \temp6 :w! F:/temp/_6<cr>
map \temp7 :w! F:/temp/_7<cr>
map \temp8 :w! F:/temp/_8<cr>
map \temp9 :w! F:/temp/_9<cr>

map \otemp :e F:/temp/_<cr>
map \otemp1 :e F:/temp/_1<cr>
map \otemp2 :e F:/temp/_2<cr>
map \otemp3 :e F:/temp/_3<cr>
map \otemp4 :e F:/temp/_4<cr>
map \otemp5 :e F:/temp/_5<cr>
map \otemp6 :e F:/temp/_6<cr>
map \otemp7 :e F:/temp/_7<cr>
map \otemp8 :e F:/temp/_8<cr>
map \otemp9 :e F:/temp/_9<cr>

Command temp-file-1 \temp1
Command temp-file-2 \temp2
Command temp-file-3 \temp3
Command temp-file-4 \temp4
Command temp-file-5 \temp5
Command temp-file-6 \temp6
Command temp-file-7 \temp7
Command temp-file-8 \temp8
Command temp-file-9 \temp9

Command open-temp-file \otemp
Command open-temp-file-1 \otemp1
Command open-temp-file-2 \otemp2
Command open-temp-file-3 \otemp3
Command open-temp-file-4 \otemp4
Command open-temp-file-5 \otemp5
Command open-temp-file-6 \otemp6
Command open-temp-file-7 \otemp7
Command open-temp-file-8 \otemp8
Command open-temp-file-9 \otemp9

""""""""""""""""""""""""""""""""""""""""""""""""""
" Misc
""""""""""""""""""""""""""""""""""""""""""""""""""

" Keep only strings matched
function! Only(regex)
	let r = a:regex
	execute '%s/' . r . '/\r&\r/g'
	execute 'v/^' . r . '$/d'
endfunction

function! OnlyInput()
	call inputsave()
	let r = input("only:")
	call inputrestore()
	if r != ""
		call Only(r)
	endif
endfunction

map \only :call OnlyInput()<cr>

" TOhtml
"let html_font="Courier New"
"let html_number_lines = 0
map \print :TOhtml<cr>:silent %s/font face="\([^*]*\)"/font style="font-size:10pt;" face="Courier New, \1"/<cr>:silent %s/^\(.*\)<br>$/<p style="margin:0px">\1<\/p>/<cr>:wq<cr>:silent !%.html<cr>

" Open directory in a new explorer window
map \openwd :call system("explorer ".expand("%:p:h"))<cr>

" Open directory in a new cmd window
map \opencd :silent !start=cmd /K cd /d %:p:h<cr>

" Remove BOM in current file
map \nobom :set nobomb<cr> :w<cr>

" hitest
map \hitest :so $VIMRUNTIME/syntax/hitest.vim<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""
" Programming
""""""""""""""""""""""""""""""""""""""""""""""""""

map <leader>ft :set filetype=

map <leader>1 :set filetype=c<cr>
map <leader>2 :set filetype=cpp<cr>
map <leader>3 :set filetype=java<cr>
map <leader>4 :set filetype=perl<cr>
map <leader>5 :set filetype=python<cr>
map <leader>6 :set filetype=tcl<cr>
map <leader>7 :set filetype=lisp<cr>
"map <leader>8 :set filetype=<cr>
map <leader>9 :set filetype=xml<cr>
map <leader>0 :set filetype=<cr>

map \11 :set filetype=ruby<cr>
map \12 :set filetype=lua<cr>
map \13 :set filetype=javascript<cr>
map \14 :set filetype=php<cr>

map \21 :set filetype=scheme<cr>
map \22 :set filetype=haskell<cr>
map \23 :set filetype=ocaml<cr>
map \24 :set filetype=smalltalk<cr>
map \25 :set filetype=erlang<cr>

map \31 :set filetype=d<cr>
map \32 :set filetype=cs<cr>
map \33 :set filetype=pascal<cr>

map \41 :set filetype=html<cr>
map \42 :set filetype=xhtml<cr>
map \43 :set filetype=xsd<cr>
map \44 :set filetype=xslt<cr>
map \45 :set filetype=ant<cr>
map \46 :set filetype=mxml<cr>

map \51 :set filetype=php<cr>
map \52 :set filetype=javascript<cr>
map \53 :set filetype=actionscript<cr>
map \54 :set filetype=mxml<cr>

map \61 :set filetype=dosbatch<cr>
map \62 :set filetype=sh<cr>

map \71 :set filetype=vim<cr>
map \72 :set filetype=make<cr>
map \73 :set filetype=sql<cr>
map \74 :set filetype=tex<cr>
map \75 :set filetype=diff<cr>

autocmd FileType perl,python,tcl,dosbatch map <buffer> <leader>! :up<cr>:!%<cr>

autocmd FileType c map <buffer> <leader>cc :up<cr>:!gcc -W -Wall % -o %:r<cr>
autocmd FileType c map <buffer> <leader>cr :up<cr>:!%:r<cr>
autocmd FileType c map <buffer> <leader><space> <leader>cc
autocmd FileType cpp map <buffer> <leader>cc :up<cr>:!g++ -W -Wall % -o %:r<cr>
autocmd FileType cpp map <buffer> <leader>cr :up<cr>:!%:r<cr>
autocmd FileType cpp map <buffer> <leader><space> <leader>cc

autocmd FileType perl map <buffer> <leader><space> :up<cr>:!perl %<cr>
autocmd FileType perl map <buffer> <leader>cc :up<cr>:!perl -c %<cr>
autocmd FileType python map <buffer> <leader><space> :up<cr>:!python %<cr>
autocmd FileType tcl map <buffer> <leader><space> :up<cr>:!tclsh %<cr>
autocmd FileType lua map <buffer> <leader><space> :up<cr>:!lua %<cr>
autocmd FileType lua map <buffer> <leader>cc :up<cr>:!luac -p %<cr>
autocmd FileType javascript map <buffer> <leader><space> :up<cr>:!js %<cr>
autocmd FileType dosbatch map <buffer> <leader><space> :up<cr>:!call %<cr>

autocmd FileType lisp map <buffer> <leader><space> :up<cr>:!clisp %<cr>

autocmd FileType xml,ant map <buffer> <leader><space> :up<cr>:%!xmllint --format %<cr>
autocmd FileType xml,ant map <buffer> <leader>cc :up<cr>:!rxp %<cr>
autocmd FileType xml map <buffer> <leader>cC :up<cr>:!rxp -V -N -s -x<cr>

autocmd FileType ant compiler ant
autocmd FileType ant map <buffer> <leader><space> :up<cr>:make<cr>

autocmd FileType ant map <buffer> \ant :up<cr>:make<space>

autocmd FileType vim map <buffer> <leader><space> :up<cr>:source %<cr>

autocmd FileType c,cpp map <buffer> <leader>= :up<cr>:%!astyle --style=ansi -p < %<cr>
autocmd FileType java map <buffer> <leader>= :up<cr>:%!astyle --style=java -p < %<cr>
autocmd FileType perl map <buffer> <leader>= :up<cr>:%!perltidy < %<cr>
autocmd FileType xml,ant map <buffer> <leader>= :up<cr>:%!xmllint --format %<cr>
autocmd FileType html map <buffer> <leader>= :up<cr>:%!tidy -f nul %<cr>













""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""
if filereadable(expand('$VIM\local_vimrc'))
	source $VIM\local_vimrc
endif


