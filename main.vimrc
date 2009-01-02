""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""                                                                ""
"" Maintainer: Kneo                                               ""
"" http://kndocs-directory.googlecode.com/svn/trunk/profiles/vim/ ""
""                                                                ""
""                                                                ""
"" Sections:                                                      ""
""                                                                ""
"" Platform                                                       ""
"" Basic                                                          ""
"" Mappings                                                       ""
"" File Format and File Encodings                                 ""
"" Look                                                           ""
"" Buffers                                                        ""
"" Folding                                                        ""
"" Tab mappings                                                   ""
"" Diff between tabs                                              ""
"" M-x for vim                                                    ""
"" Misc                                                           ""
"" File Types                                                     ""
"" Plugin                                                         ""
"" Load more                                                      ""
""                                                                ""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



""""""""""""""""""""""""""""""""""""""""""""""""""
" Platform
""""""""""""""""""""""""""""""""""""""""""""""""""

let win = 'win'
let win32 = 'win'
let win64 = 'win'
let linux = 'unix'
let unix = 'unix'

function! Platform()
  if has('win32')
    return g:win32
  elseif has('win64')
    return g:win64
  elseif has('unix')
    return g:unix
  elseif has('win32unix')
    throw 'Cygwin is not tested'
  elseif has('mac') or has('macunix')
    throw 'Mac is not supported'
  elseif has('win16')
    throw 'win16 is not supported'
  else
    throw 'Unknown platform'
  endif
endfunction

let os = Platform()

if os == win
  let $VIMFILES = expand('$VIM/vimfiles')
else
  let $VIMFILES = expand('~/.vim')
end

""""""""""""""""""""""""""""""""""""""""""""""""""
" Basic
""""""""""""""""""""""""""""""""""""""""""""""""""

" Generl
set nocompatible
set nobackup
set number
set ignorecase
set incsearch
set hlsearch
"set whichwrap+=<,>,h,l
set backspace=indent,eol,start "?
set wrap

set ruler "?
set magic "?

if os == win
  set vb t_vb=
else
  set noerrorbells
  set novisualbell
  set t_vb=
endif

if os == linux
  set nowritebackup
  set noswapfile

  set scrolloff=5

  set showmatch
  set matchtime=2

  set wildmenu "?

  "Do not redraw, when running macros.. lazyredraw
  set lazyredraw "?

  "Change buffer - without saving
  set hidden "?
endif

"set history=400

" Indent
set tabstop=4
set shiftwidth=4
set autoindent

if os == linux
  set expandtab
  set smarttab
  set smartindent
  set linebreak "?
  "C-style indeting
  "set cindent
endif

""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ","

map <leader>cd :cd %:p:h<cr>

map <leader>h :help<space>
map <leader>K :exe "help" expand("<cword>")<cr>

if os == win
  map \rc :e $VIM/main.vimrc<cr>
  map \lrc :e $VIM/local_vimrc<cr>
  map \sorc :source $VIM/_vimrc<cr>
  map \slrc :source $VIM/local_vimrc<cr>
  map \r$ :%s/\r$//<cr>
else
  map \rc :e $HOME/.vimrc<cr>
  map \lrc :e $HOME/.vimrc_local<cr>
  map \sorc :source $HOME/.vimrc<cr>
  map \slrc :source $HOME/.vimrc_local<cr>
  map \r$ :%s/\r$//<cr>
endif

map \msn i<c-r>=strftime("%Y-%m-%d %H:%M")<cr> MSN<cr>

set winaltkeys=no
map <M-y> "+yy
map <M-Y> gg"+yG<C-O><C-O>
noremap <M-a> <C-a>
noremap <M-v> <C-v>
noremap <M-x> <C-x>


map <leader>t2 :set expandtab<cr>:set shiftwidth=2<cr>
map <leader>t3 :set expandtab<cr>:set shiftwidth=3<cr>
map <leader>t4 :set expandtab<cr>:set shiftwidth=4<cr>
map <leader>tt :set noexpandtab<cr>:set shiftwidth=4<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""
" File Format and File Encodings
""""""""""""""""""""""""""""""""""""""""""""""""""
" File format
if os == win
  set ffs=dos,unix,mac
else
  set ffs=unix,dos,mac
endif

nmap <leader>fd :set ff=dos<cr>
nmap <leader>fD :set ffs=dos<cr>:e<cr>
"nmap <leader>fD :e ++ff=dos<cr>
nmap <leader>fu :set ff=unix<cr>
nmap <leader>fm :set ff=mac<cr>

" File encoding
if os == win
  set fileencodings=ucs-bom,utf-8
else
  set fileencodings=utf-8,gbk,ucs-bom,default,latin1
  "nmap <leader>eu :e enc=utf-8<cr>
  "nmap <leader>eg :e enc=gbk<cr>
endif


""""""""""""""""""""""""""""""""""""""""""""""""""
" Look
""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable

if os == win
  set guifont=Monaco:h10:cDEFAULT
elseif os == linux
  set guifont=Monospace\ 11
endif

if has("gui_running")
  set background=dark
  if os == win
    colorscheme ps_color
    let psc_style='cool'
    set guioptions-=T
  else
    colorscheme moria
  endif
else
  set background=dark
"  colorscheme zellner
  colorscheme darkblue
endif

set showcmd

set laststatus=2
set statusline=\ %<%F%m%r%h\ %w\ \ [%{&ff}][%{&fenc!=''?&fenc:&enc}%{&bomb?',BOM':''}][%Y]\ %=%4l,%-10.(%c%V%)\ %P\ 

if os == linux
  function! CurDir()
    let curdir = substitute(getcwd(), '/home/pleiades/', "~/", "g")
    return curdir
  endfunction

  "Format the statusline
  set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c
endif


""""""""""""""""""""""""""""""""""""""""""""""""""
" Buffers
""""""""""""""""""""""""""""""""""""""""""""""""""
" XXX: how to use it?
if os == linux
  "Restore cursor to file position in previous editing session
  set viminfo='10,\"100,:20,%,n~/.viminfo
  au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
endif


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
  let cmd = input("M-x ", "", "customlist,CommandList")
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
map <leader>mx :call MXInput()<cr>

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

" Some useful mappings

Command copy-all gg"+yG``

" Temporary Files

" XXX: Don't use $TMPDIR, which conflicts with taglist...
if os == win
  let $TEMPDIR = 'F:/temp'
else
  let $TEMPDIR = '~/tmp'
endif

map <leader>W :cd $TEMPDIR<cr>:w! _<cr>

map \temp1 :w! $TEMPDIR/_1<cr>
map \temp2 :w! $TEMPDIR/_2<cr>
map \temp3 :w! $TEMPDIR/_3<cr>
map \temp4 :w! $TEMPDIR/_4<cr>
map \temp5 :w! $TEMPDIR/_5<cr>
map \temp6 :w! $TEMPDIR/_6<cr>
map \temp7 :w! $TEMPDIR/_7<cr>
map \temp8 :w! $TEMPDIR/_8<cr>
map \temp9 :w! $TEMPDIR/_9<cr>

map \otemp :e $TEMPDIR/_<cr>
map \otemp1 :e $TEMPDIR/_1<cr>
map \otemp2 :e $TEMPDIR/_2<cr>
map \otemp3 :e $TEMPDIR/_3<cr>
map \otemp4 :e $TEMPDIR/_4<cr>
map \otemp5 :e $TEMPDIR/_5<cr>
map \otemp6 :e $TEMPDIR/_6<cr>
map \otemp7 :e $TEMPDIR/_7<cr>
map \otemp8 :e $TEMPDIR/_8<cr>
map \otemp9 :e $TEMPDIR/_9<cr>

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
" Script
""""""""""""""""""""""""""""""""""""""""""""""""""

function! ScriptLoad(name)
  let name = a:name
  exe 'source' '$VIMFILES/script/'.name.'.vim'
endfunction

" TODO: optional arg
function! GetScriptList()
  let list = split(glob('$VIMFILES/script/*.vim'), '\n')
  let list = map(list, "fnamemodify(v:val, ':t:r')")
  return sort(list)
endfunction

let s:script_list = GetScriptList()

function! ScriptList(ArgLead, CmdLine, CursorPos)
  let alist = s:script_list
  let nlist = []
  for i in alist
    if stridx(tolower(i), tolower(a:ArgLead)) == 0
      call add(nlist, i)
    endif
  endfor
  return nlist
endfunction

function! ScriptInput()
  call inputsave()
  let name = input("Script: ", "", "customlist,ScriptList")
  call inputrestore()
  if name != ""
    call ScriptLoad(name)
  endif
endfunction

function! Script(...)
  if a:0 == 0
    call ScriptInput()
  elseif a:0 == 1
    call ScriptLoad(a:1)
  else
    echoerr 'Too many arguments. Only 0 or 1 argument is allowed.'
  endif
endfunction

command! -complete=customlist,ScriptList -nargs=? Script call Script(<q-args>)

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
Command only \only


map \wrap :set wrap<cr>:set guioptions-=b<cr>
Command wrapline \wrap

map \nowrap :set nowrap<cr>:set guioptions+=b<cr>
Command nowrapline \nowrap

map \tagdoc :helptags $VIMFILES/doc<cr>
Command tagdoc \tagdoc

if os == win
  " TOhtml
  "let html_font="Courier New"
  "let html_number_lines = 0
  map \print :TOhtml<cr>:silent %s/font face="\([^*]*\)"/font style="font-size:10pt;" face="Courier New, \1"/<cr>:silent %s/^\(.*\)<br>$/<p style="margin:0px">\1<\/p>/<cr>:wq<cr>:silent !%.html<cr>
  Command TOHtmlForOutlook \print

  " Open directory in a new explorer window
  map \openwd :call system("explorer ".expand("%:p:h"))<cr>
  Command open-browser \openwd

  " Open directory in a new cmd window
  map \opencd :silent !start=cmd /K cd /d %:p:h<cr>
  Command open-command \opencd
endif

" Remove BOM in current file
map \nobom :set nobomb<cr> :w<cr>
Command remove-bom \nobom

" hitest
map \hitest :so $VIMRUNTIME/syntax/hitest.vim<cr>
Command hitest \hitest


""""""""""""""""""""""""""""""""""""""""""""""""""
" File Types
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

if os == win
  map \61 :set filetype=dosbatch<cr>
  map \62 :set filetype=sh<cr>
else
  map \61 :set filetype=sh<cr>
  map \62 :set filetype=dosbatch<cr>
endif

map \71 :set filetype=vim<cr>
map \72 :set filetype=make<cr>
map \73 :set filetype=sql<cr>
map \74 :set filetype=tex<cr>
map \75 :set filetype=diff<cr>


  """"""""""""""""""""""""""""""
  " Util
  """"""""""""""""""""""""""""""
  function! FileDir()
    let s = expand("%:h")
    return s == '' ? '.' : s
  endfunction

  """"""""""""""""""""""""""""""
  " VIM
  """"""""""""""""""""""""""""""
  autocmd FileType vim map <buffer> <leader><space> :up<cr>:source %<cr>

  autocmd FileType vim set shiftwidth=2
  autocmd FileType vim set tabstop=2
  autocmd FileType vim set expandtab

  """"""""""""""""""""""""""""""
  " C mappings
  """""""""""""""""""""""""""""""
"  autocmd FileType c map <buffer> <leader>cc :up<cr>:!gcc -W -Wall %<cr>

  if os == linux
    autocmd FileType c map <buffer> <leader>cc :up<cr>:exe "!gcc -W -Wall % -o ".FileDir().'/a.out'<cr>
    autocmd FileType c map <buffer> <leader>cr :up<cr>:exe '!'.FileDir().'/a.out'<cr>
  else
    autocmd FileType c map <buffer> <leader>cc :up<cr>:!gcc -W -Wall % -o %:r<cr>
    autocmd FileType c map <buffer> <leader>cr :up<cr>:!%:r<cr>
  endif

  autocmd FileType c map <buffer> <leader><space> <leader>cc

  """"""""""""""""""""""""""""""
  " C++ mappings
  """""""""""""""""""""""""""""""
"  autocmd FileType cpp map <buffer> <leader>cc :up<cr>:!g++ -W -Wall %<cr>
  if os == linux
    autocmd FileType cpp map <buffer> <leader>cc :up<cr>:exe "!g++ -W -Wall % -o ".FileDir().'/a.out'<cr>
    autocmd FileType cpp map <buffer> <leader>cr :up<cr>:exe '!'.FileDir().'/a.out'<cr>
  else
    autocmd FileType cpp map <buffer> <leader>cc :up<cr>:!g++ -W -Wall % -o %:r<cr>
    autocmd FileType cpp map <buffer> <leader>cr :up<cr>:!%:r<cr>
  endif

  autocmd FileType cpp map <buffer> <leader><space> <leader>cc

  """"""""""""""""""""""""""""""
  " C/C++
  """""""""""""""""""""""""""""""
  autocmd FileType c,cpp map <buffer> <leader>= :up<cr>:%!astyle --style=ansi -p < %<cr>

  """""""""""""""""""""""""""""""
  " Java
  """""""""""""""""""""""""""""""
  autocmd FileType java map <buffer> <leader>= :up<cr>:%!astyle --style=java -p < %<cr>


  """""""""""""""""""""""""""""""
  " Perl
  """""""""""""""""""""""""""""""
  autocmd FileType perl map <buffer> <leader><space> :up<cr>:!perl %<cr>
  autocmd FileType perl map <buffer> <leader>cc :up<cr>:!perl -c %<cr>
  if os == win
    autocmd FileType perl map <buffer> <leader>= :up<cr>:%!perltidy < %<cr>
  endif


  """""""""""""""""""""""""""""""
  " Python
  """""""""""""""""""""""""""""""
  autocmd FileType python map <buffer> <leader><space> :up<cr>:!python %<cr>


  """""""""""""""""""""""""""""""
  " Tcl
  """""""""""""""""""""""""""""""
  autocmd FileType tcl map <buffer> <leader><space> :up<cr>:!tclsh %<cr>


  """""""""""""""""""""""""""""""
  " Lua
  """""""""""""""""""""""""""""""
  autocmd FileType lua map <buffer> <leader><space> :up<cr>:!lua %<cr>
  autocmd FileType lua map <buffer> <leader>cc :up<cr>:!luac -p %<cr>


  """""""""""""""""""""""""""""""
  " Lisp
  """""""""""""""""""""""""""""""
  autocmd FileType lisp map <buffer> <leader><space> :up<cr>:!clisp %<cr>


  """""""""""""""""""""""""""""""
  " XML & Ant
  """""""""""""""""""""""""""""""
  autocmd FileType xml,ant map <buffer> <leader>= :up<cr>:%!xmllint --format %<cr>
  if os == win
    autocmd FileType xml,ant map <buffer> <leader>cc :up<cr>:!rxp %<cr>
    autocmd FileType xml map <buffer> <leader>cC :up<cr>:!rxp -V -N -s -x<cr>
  endif
  autocmd FileType xml map <buffer> <leader><space> <leader>=

  autocmd FileType ant compiler ant
  autocmd FileType ant map <buffer> <leader><space> :up<cr>:make<cr>
  autocmd FileType ant map <buffer> \ant :up<cr>:make<space>

  """""""""""""""""""""""""""""""
  " JavaScript
  """""""""""""""""""""""""""""""
  autocmd FileType javascript map <buffer> <leader><space> :up<cr>:!js %<cr>

  """""""""""""""""""""""""""""""
  " HTML
  """""""""""""""""""""""""""""""
  if os == win
    autocmd FileType html map <buffer> <leader>= :up<cr>:%!tidy -f nul %<cr>
  else
    autocmd FileType html map <buffer> <leader>= :up<cr>:%!tidy -f /dev/null %<cr>
  end

  """""""""""""""""""""""""""""""
  " Shell
  """""""""""""""""""""""""""""""
  autocmd FileType sh set ff=unix " XXX: does it have any potential problem?

  """""""""""""""""""""""""""""""
  " DOS Batch
  """""""""""""""""""""""""""""""
  autocmd FileType dosbatch map <buffer> <leader><space> :up<cr>:!call %<cr>

  """""""""""""""""""""""""""""""
  " SVN
  """""""""""""""""""""""""""""""
  autocmd FileType svn set spell " XXX: how to avoid Chinese spell check?


  """""""""""""""""""""""""""""""
  " Others
  """""""""""""""""""""""""""""""
  autocmd FileType perl,python,tcl,dosbatch map <buffer> <leader>! :up<cr>:!%<cr>


  """""""""""""""""""""""""""""""
  "
  """""""""""""""""""""""""""""""



""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin
""""""""""""""""""""""""""""""""""""""""""""""""""

" vcscommand.vim
let VCSCommandMapPrefix = '\c'

" calendar.vim
nmap <unique> \\cal <Plug>CalendarV
nmap <unique> \\caL <Plug>CalendarH

" lookupfile.vim
let g:LookupFile_DisableDefaultMap = 1

""""""""""""""""""""""""""""""""""""""""""""""""""
" Load more
""""""""""""""""""""""""""""""""""""""""""""""""""

let local_vimrc = os == win ? '$VIM\local_vimrc' : '~/.vimrc_local'

if filereadable(expand(local_vimrc))
  exe 'source' local_vimrc
endif


