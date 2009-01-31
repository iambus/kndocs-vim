""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""                                                                ""
"" Maintainer: Kneo                                               ""
"" Last Modified: 2009-01-31 18:07:20                             ""
"" Version: unversioned                                           ""
"" Latest Version:                                                ""
"" http://kndocs-directory.googlecode.com/svn/trunk/profiles/vim/ ""
""                                                                ""
"" Sections:                                                      ""
""                                                                ""
"" Platform                                                       ""
"" Load some scripts from $VIMFILES/before                        ""
"" Basic                                                          ""
"" Mappings                                                       ""
"" M-x for vim                                                    ""
"" File Format and File Encodings                                 ""
"" Look                                                           ""
"" Buffers                                                        ""
"" Folding                                                        ""
"" Tab mappings                                                   ""
"" Diff between tabs                                              ""
"" Misc                                                           ""
"" File Types                                                     ""
"" Plugins                                                        ""
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
" Load some scripts from $VIMFILES/before
""""""""""""""""""""""""""""""""""""""""""""""""""
function! RunBeforeScripts()
  let list = split(glob('$VIMFILES/before/*.vim'), '\n')
  for script in list
      exe 'source' script
  endfor
endfunction
call RunBeforeScripts()


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
" Just use the default mapleader '\'. Whenever I want ',', give ',' instead of '<leader>'.
let mapleader = '\'

noremap ,, ,

map ,cd :cd %:p:h<cr>

map ,h :help<space>
map ,K :exe "help" expand("<cword>")<cr>

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

set winaltkeys=no
map <M-y> "+yy
map <M-Y> gg"+yG<C-O><C-O>
noremap <M-a> <C-a>
noremap <M-v> <C-v>
noremap <M-x> <C-x>


map ,t2 :set expandtab<cr>:set shiftwidth=2<cr>
map ,t3 :set expandtab<cr>:set shiftwidth=3<cr>
map ,t4 :set expandtab<cr>:set shiftwidth=4<cr>
map ,tt :set noexpandtab<cr>:set shiftwidth=4<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""
" M-x for vim
""""""""""""""""""""""""""""""""""""""""""""""""""

" Source code for Command is in $VIMFILES/before/Command.vim

map <M-x> <plug>Command
imap <M-x> <C-O><plug>Command
map ,mx <plug>Command
map ,x <plug>Command


" Some useful mappings

Command copy-all gg"+yG``

Command msn i<c-r>=strftime("%Y-%m-%d %H:%M")<cr> MSN<cr>

" Temporary Files

" XXX: Don't use $TMPDIR, which conflicts with taglist...
if os == win
  let $TEMPDIR = 'F:/temp'
else
  let $TEMPDIR = expand('~/tmp')
endif

map ,W :cd $TEMPDIR<cr>:w! _<cr>

Command temp-file-1 :w! $TEMPDIR/_1<cr>
Command temp-file-2 :w! $TEMPDIR/_2<cr>
Command temp-file-3 :w! $TEMPDIR/_3<cr>
Command temp-file-4 :w! $TEMPDIR/_4<cr>
Command temp-file-5 :w! $TEMPDIR/_5<cr>
Command temp-file-6 :w! $TEMPDIR/_6<cr>
Command temp-file-7 :w! $TEMPDIR/_7<cr>
Command temp-file-8 :w! $TEMPDIR/_8<cr>
Command temp-file-9 :w! $TEMPDIR/_9<cr>

Command open-temp-file   :e $TEMPDIR/_<cr>
Command open-temp-file-1 :e $TEMPDIR/_1<cr>
Command open-temp-file-2 :e $TEMPDIR/_2<cr>
Command open-temp-file-3 :e $TEMPDIR/_3<cr>
Command open-temp-file-4 :e $TEMPDIR/_4<cr>
Command open-temp-file-5 :e $TEMPDIR/_5<cr>
Command open-temp-file-6 :e $TEMPDIR/_6<cr>
Command open-temp-file-7 :e $TEMPDIR/_7<cr>
Command open-temp-file-8 :e $TEMPDIR/_8<cr>
Command open-temp-file-9 :e $TEMPDIR/_9<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""
" File Format and File Encodings
""""""""""""""""""""""""""""""""""""""""""""""""""
" File format
if os == win
  set ffs=dos,unix,mac
else
  set ffs=unix,dos,mac
endif

nmap ,fd :set ff=dos<cr>
nmap ,fD :set ffs=dos<cr>:e<cr>
"nmap ,fD :e ++ff=dos<cr>
nmap ,fu :set ff=unix<cr>
nmap ,fm :set ff=mac<cr>

" File encoding
if os == win
  set fileencodings=ucs-bom,utf-8
else
  set fileencodings=utf-8,gbk,ucs-bom,default,latin1
  "nmap ,eu :e enc=utf-8<cr>
  "nmap ,eg :e enc=gbk<cr>
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
    let curdir = substitute(getcwd(), expand('$HOME/'), "~/", "g")
    return curdir
  endfunction

  "Format the statusline
  "set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c
endif


""""""""""""""""""""""""""""""""""""""""""""""""""
" Buffers
""""""""""""""""""""""""""""""""""""""""""""""""""

map ,bn :bnext<cr>
map ,bp :bprevious<cr>

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

Command diff-first-two-tabs :call DiffTabs(1, 2)<cr>
Command diff-last-two-tabs :call DiffEndTabs()<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""
" Script
""""""""""""""""""""""""""""""""""""""""""""""""""

" FIXME: Too many duplicated code...

" Load Script

function! ScriptLoad(name)
  exe 'source' '$VIMFILES/script/'.a:name.'.vim'
endfunction

function! GetScriptList()
  let list = split(glob('$VIMFILES/script/*.vim'), '\n')
  let list = map(list, "fnamemodify(v:val, ':t:r')")
  return sort(list)
endfunction

let s:script_list = GetScriptList()

function! ScriptList(ArgLead, CmdLine, CursorPos)
  return filter(s:script_list, "stridx(tolower(v:val), tolower(a:ArgLead)) == 0")
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


" Open Script

function! ScriptOpen(name)
  if a:name != ''
    exe 'edit' '$VIMFILES/script/'.a:name.'.vim'
  endif
endfunction

function! OpenScriptInput()
  call inputsave()
  let name = input("Script: ", "", "customlist,ScriptList")
  call inputrestore()
  if name != ""
    call ScriptOpen(name)
  endif
endfunction

function! OpenScript(...)
  if a:0 == 0
    call OpenScriptInput()
  elseif a:0 == 1
    call ScriptOpen(a:1)
  else
    echoerr 'Too many arguments. Only 0 or 1 argument is allowed.'
  endif
endfunction

command! -complete=customlist,ScriptList -nargs=? OpenScript call OpenScript(<q-args>)


" Open Script

function! PluginOpen(name)
  if a:name != ''
    exe 'edit' '$VIMFILES/plugin/'.a:name.'.vim'
  endif
endfunction

function! GetPluginList()
  let list = split(glob('$VIMFILES/plugin/*.vim'), '\n')
  let list = map(list, "fnamemodify(v:val, ':t:r')")
  return sort(list)
endfunction

let s:plugin_list = GetPluginList()

function! PluginList(ArgLead, CmdLine, CursorPos)
  return filter(s:plugin_list, "stridx(tolower(v:val), tolower(a:ArgLead)) == 0")
endfunction


function! OpenPluginInput()
  call inputsave()
  let name = input("Plugin: ", "", "customlist,PluginList")
  call inputrestore()
  if name != ""
    call PluginOpen(name)
  endif
endfunction

function! OpenPlugin(...)
  if a:0 == 0
    call OpenPluginInput()
  elseif a:0 == 1
    call PluginOpen(a:1)
  else
    echoerr 'Too many arguments. Only 0 or 1 argument is allowed.'
  endif
endfunction

command! -complete=customlist,PluginList -nargs=? OpenPlugin call OpenPlugin(<q-args>)


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

Command only-text :call OnlyInput()<cr>


Command wrapline :set wrap<cr>:set guioptions-=b<cr>

Command nowrapline :set nowrap<cr>:set guioptions+=b<cr>

Command tagdoc :helptags $VIMFILES/doc<cr>

if os == win
  " TOhtml
  "let html_font="Courier New"
  "let html_number_lines = 0
  Command TOHtmlForOutlook :TOhtml<cr>:silent %s/font face="\([^*]*\)"/font style="font-size:10pt;" face="Courier New, \1"/<cr>:silent %s/^\(.*\)<br>$/<p style="margin:0px">\1<\/p>/<cr>:wq<cr>:silent !%.html<cr>

  " Open directory in a new explorer window
  Command openwd :call system("explorer ".expand("%:p:h"))<cr>
  Command open-browser :call system("explorer ".expand("%:p:h"))<cr>

  " Open directory in a new cmd window
  Command opencd :silent !start=cmd /K cd /d %:p:h<cr>
  Command open-command :silent !start=cmd /K cd /d %:p:h<cr>
endif

" Remove BOM in current file
Command remove-bom :set nobomb<cr> :w<cr>
Command      nobom :set nobomb<cr> :w<cr>

" hitest
Command hitest :so $VIMRUNTIME/syntax/hitest.vim<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""
" File Types
""""""""""""""""""""""""""""""""""""""""""""""""""

map ,ft :set filetype=

map ,1 :set filetype=c<cr>
map ,2 :set filetype=cpp<cr>
map ,3 :set filetype=java<cr>
map ,4 :set filetype=perl<cr>
map ,5 :set filetype=python<cr>
map ,6 :set filetype=tcl<cr>
map ,7 :set filetype=lisp<cr>
"map ,8 :set filetype=<cr>
map ,9 :set filetype=xml<cr>
map ,0 :set filetype=<cr>

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
  autocmd FileType vim map <buffer> ,<space> :up<cr>:source %<cr>

  autocmd FileType vim set shiftwidth=2
  autocmd FileType vim set tabstop=2
  autocmd FileType vim set expandtab

  autocmd FileType vim set ff=unix " XXX: does it have any potential problem?

  """"""""""""""""""""""""""""""
  " C mappings
  """""""""""""""""""""""""""""""
"  autocmd FileType c map <buffer> ,cc :up<cr>:!gcc -W -Wall %<cr>

  if os == linux
    autocmd FileType c map <buffer> ,cc :up<cr>:exe "!gcc -W -Wall % -o ".FileDir().'/a.out'<cr>
    autocmd FileType c map <buffer> ,cr :up<cr>:exe '!'.FileDir().'/a.out'<cr>
  else
    autocmd FileType c map <buffer> ,cc :up<cr>:!gcc -W -Wall % -o %:r<cr>
    autocmd FileType c map <buffer> ,cr :up<cr>:!%:r<cr>
  endif

  autocmd FileType c map <buffer> ,<space> ,cc

  """"""""""""""""""""""""""""""
  " C++ mappings
  """""""""""""""""""""""""""""""
"  autocmd FileType cpp map <buffer> ,cc :up<cr>:!g++ -W -Wall %<cr>
  if os == linux
    autocmd FileType cpp map <buffer> ,cc :up<cr>:exe "!g++ -W -Wall % -o ".FileDir().'/a.out'<cr>
    autocmd FileType cpp map <buffer> ,cr :up<cr>:exe '!'.FileDir().'/a.out'<cr>
  else
    autocmd FileType cpp map <buffer> ,cc :up<cr>:!g++ -W -Wall % -o %:r<cr>
    autocmd FileType cpp map <buffer> ,cr :up<cr>:!%:r<cr>
  endif

  autocmd FileType cpp map <buffer> ,<space> ,cc

  """"""""""""""""""""""""""""""
  " C/C++
  """""""""""""""""""""""""""""""
  autocmd FileType c,cpp map <buffer> ,= :up<cr>:%!astyle --style=ansi -p < %<cr>

  """""""""""""""""""""""""""""""
  " Java
  """""""""""""""""""""""""""""""
  autocmd FileType java map <buffer> ,= :up<cr>:%!astyle --style=java -p < %<cr>

  autocmd FileType java map <buffer> ,cc :up<cr>:!javapro -c %<cr>
  autocmd FileType java map <buffer> ,cr :up<cr>:!javapro -x %<cr>
  autocmd FileType java map <buffer> ,c<space> :up<cr>:!javapro -cx %<cr>

  autocmd FileType java map <buffer> ,<space> ,cr

  """""""""""""""""""""""""""""""
  " Perl
  """""""""""""""""""""""""""""""
  autocmd FileType perl map <buffer> ,<space> :up<cr>:!perl %<cr>
  autocmd FileType perl map <buffer> ,cc :up<cr>:!perl -c %<cr>
  if os == win
    autocmd FileType perl map <buffer> ,= :up<cr>:%!perltidy < %<cr>
  endif


  """""""""""""""""""""""""""""""
  " Python
  """""""""""""""""""""""""""""""
  autocmd FileType python map <buffer> ,<space> :up<cr>:!python %<cr>


  """""""""""""""""""""""""""""""
  " Tcl
  """""""""""""""""""""""""""""""
  autocmd FileType tcl map <buffer> ,<space> :up<cr>:!tclsh %<cr>


  """""""""""""""""""""""""""""""
  " Lua
  """""""""""""""""""""""""""""""
  autocmd FileType lua map <buffer> ,<space> :up<cr>:!lua %<cr>
  autocmd FileType lua map <buffer> ,cc :up<cr>:!luac -p %<cr>


  """""""""""""""""""""""""""""""
  " Lisp
  """""""""""""""""""""""""""""""
  autocmd FileType lisp map <buffer> ,<space> :up<cr>:!clisp %<cr>


  """""""""""""""""""""""""""""""
  " Erlang
  """""""""""""""""""""""""""""""
  autocmd FileType erlang map <buffer> ,<space> :up<cr>:!escript %<cr>


  """""""""""""""""""""""""""""""
  " XML & XMLs
  """""""""""""""""""""""""""""""
  autocmd FileType xml,ant,xsd map <buffer> ,= :up<cr>:%!xmllint --format %<cr>
  if os == win
    autocmd FileType xml,ant,xsd map <buffer> ,cc :up<cr>:!rxp %<cr>
    autocmd FileType xml,ant,xsd map <buffer> ,cC :up<cr>:!rxp -V -N -s -x<cr>
  endif
  autocmd FileType xml map <buffer> ,<space> ,=

  autocmd FileType ant compiler ant
  autocmd FileType ant map <buffer> ,<space> :up<cr>:make<cr>
  autocmd FileType ant map <buffer> \ant :up<cr>:make<space>

  function! ValidateXML()
    let f = expand('%:t:r')
    exe '!' 'xmllint' '--schema' f.'.xsd' f.'.xml'
  endfunction
  Command validate-xml :call ValidateXML()<cr>

  """""""""""""""""""""""""""""""
  " JavaScript
  """""""""""""""""""""""""""""""
  autocmd FileType javascript map <buffer> ,<space> :up<cr>:!js %<cr>

  """""""""""""""""""""""""""""""
  " HTML
  """""""""""""""""""""""""""""""
  if os == win
    autocmd FileType html map <buffer> ,= :up<cr>:%!tidy -f nul %<cr>
  else
    autocmd FileType html map <buffer> ,= :up<cr>:%!tidy -f /dev/null %<cr>
  end

  """""""""""""""""""""""""""""""
  " Shell
  """""""""""""""""""""""""""""""
  autocmd FileType sh set ff=unix " XXX: does it have any potential problem?

  """""""""""""""""""""""""""""""
  " DOS Batch
  """""""""""""""""""""""""""""""
  autocmd FileType dosbatch map <buffer> ,<space> :up<cr>:!call %<cr>

  """"""""""""""""""""""""""""""""""""""""""""""""""
  " .as & .mxml
  """"""""""""""""""""""""""""""""""""""""""""""""""
  au BufNewFile,BufRead *.mxml set filetype=mxml
  au BufNewFile,BufRead *.as set filetype=actionscript


  """""""""""""""""""""""""""""""
  " SVN
  """""""""""""""""""""""""""""""
  autocmd FileType svn set spell " XXX: how to avoid Chinese spell check?


  """""""""""""""""""""""""""""""
  " Others
  """""""""""""""""""""""""""""""
  autocmd FileType perl,python,tcl,dosbatch map <buffer> ,! :up<cr>:!%<cr>


  """""""""""""""""""""""""""""""
  "
  """""""""""""""""""""""""""""""



""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""

  """""""""""""""""""""""""
  " bufexplorer.vim       "
  """""""""""""""""""""""""
  " Nothing to change

  """""""""""""""""""""""""
  " taglist.vim           "
  """""""""""""""""""""""""
  if !executable('ctags')
    let g:loaded_taglist = 'no'
  endif

  """""""""""""""""""""""""
  " vcscommand.vim        "
  """""""""""""""""""""""""
  let g:VCSCommandMapPrefix = '\v'
  if os == linux
    nmap \vv :tabnew %<cr><Plug>VCSVimDiff
  endif
  autocmd FileType VCSCommit set spell " XXX: how to avoid Chinese spell check?

  """""""""""""""""""""""""
  " calendar.vim          "
  """""""""""""""""""""""""
  nmap <unique> \\cal <Plug>CalendarV
  nmap <unique> \\caL <Plug>CalendarH
  " TODO: set diary path

  """""""""""""""""""""""""
  " lookupfile.vim        "
  """""""""""""""""""""""""
  let g:LookupFile_DisableDefaultMap = 1

  """""""""""""""""""""""""
  " favex.vim             "
  """""""""""""""""""""""""
  let g:favex_fs='\fs'
  let g:favex_ff='\ff'
  let g:favex_fe='\fe'
  let g:favex_fd='\fd'
  let g:favlist_path = os == linux ? '$HOME/.vimfavlist' : '$HOME/_vimfavlist'

  """""""""""""""""""""""""
  " DirDiff.vim           "
  """""""""""""""""""""""""
  map <unique> \dg <Plug>DirDiffGet
  map <unique> \dp <Plug>DirDiffPut
  map <unique> \dj <Plug>DirDiffNext
  map <unique> \dk <Plug>DirDiffPrev

  """""""""""""""""""""""""
  " timestamp.vim         "
  """""""""""""""""""""""""
  " XXX: How to make %z = +0800 on Windows?
  " Note: I have removed the timezone information because I don't know how to show time zone in format like +0800 on Windows.
  let g:timestamp_rep = '%Y-%m-%d %H:%M:%S'
  "let g:timestamp_regexp = '\v\C%(<%(Last %([cC]hanged?|modified)|Modified)\s*:\s+)@<=\a+ \d{2} \a+ \d{4} \d{2}:\d{2}:\d{2}%(\s+[AP]M)?%(\s+\a+)?|TIMESTAMP'
  let g:timestamp_regexp = '\v\C%(<%(Last %([cC]hanged?|modified)|Modified)\s*:\s+)@<=\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}|\%TIMESTAMP\%'
  map <unique> \time a%TIMESTAMP%<ESC>
  Command insert-timestamp a%TIMESTAMP%<ESC>


  """""""""""""""""""""""""
  " mru.vim               "
  """""""""""""""""""""""""
  " Nothing to change

  """""""""""""""""""""""""
  " xml.vim               "
  """""""""""""""""""""""""
  " TODO: remap

  """""""""""""""""""""""""
  " matchit.vim           "
  """""""""""""""""""""""""
  " TODO: remap

  """""""""""""""""""""""""
  " snippetsEmu.vim       "
  """""""""""""""""""""""""
  " Nothing to change

  """""""""""""""""""""""""
  " showit.vim            "
  """""""""""""""""""""""""
  nmap <unique> <silent> \mm <Plug>MarkSet
  vmap <unique> <silent> \mm <Plug>MarkSet
  nmap <unique> <silent> \mr <Plug>MarkRegex
  vmap <unique> <silent> \mr <Plug>MarkRegex
  nmap <unique> <silent> \mn <Plug>MarkClear

  " Highlight current line
  function! ShowLine()
    let linecontent = '\%' . line(".") . "l.*"
    exe 'Mark' linecontent
  endfunction

  " Highlight current word (other same words are not highlighted)
  function! ShowIt()
    let lineno = '\%' . line(".") . "l"
    let colno = '\%' . col(".") . "c"
    let p = lineno . '\<' . '\w*' . colno . '\w*' . '\>'
    exe 'Mark' p
  endfunction

  nmap <unique> <silent> \ml :call ShowLine()<cr>
  nmap <unique> <silent> \mi :call ShowIt()<cr>

  hi MarkWord1  ctermbg=Green    ctermfg=Black  guibg=#A4E57E    guifg=Black
  hi MarkWord2  ctermbg=Yellow   ctermfg=Black  guibg=#FFDB72    guifg=Black
  hi MarkWord3  ctermbg=Cyan     ctermfg=Black  guibg=#8CCBEA    guifg=Black

  autocmd ColorScheme * source $VIMFILES/plugin/showit.vim

  """""""""""""""""""""""""
  " mark.vim              "
  """""""""""""""""""""""""
  """ TODO: protect mark.vim from mapping for *, #, \*, \#, \/, \?


  """""""""""""""""""""""""
  " text.vim              "
  """""""""""""""""""""""""
  " Nothing to change

  """""""""""""""""""""""""
  " genutils.vim          "
  """""""""""""""""""""""""
  " Nothing to change

  """""""""""""""""""""""""
  " surround.vim          "
  """""""""""""""""""""""""
  " Nothing to change

  """""""""""""""""""""""""
  " NERD_commenter.vim    "
  """""""""""""""""""""""""
  let g:NERDCreateDefaultMappings = 0
  " TODO: nmap/vmap instead of map
   map <unique> \cc       <plug>NERDCommenterComment
   map <unique> \c<space> <plug>NERDCommenterToggle
   map <unique> \cm       <plug>NERDCommenterMinimal
   map <unique> \cs       <plug>NERDCommenterSexy
   map <unique> \ci       <plug>NERDCommenterInvert
   map <unique> \cy       <plug>NERDCommenterYank
   map <unique> \cl       <plug>NERDCommenterAlignLeft
   map <unique> \cb       <plug>NERDCommenterAlignBoth
   map <unique> \cn       <plug>NERDCommenterNest
   map <unique> \cu       <plug>NERDCommenterUncomment
   map <unique> \c$       <plug>NERDCommenterToEOL
   map <unique> \cA       <plug>NERDCommenterAppend
  nmap <unique> \ca       <plug>NERDCommenterAltDelims

  let g:NERDShutUp=1

  """""""""""""""""""""""""
  " NERD_tree.vim         "
  """""""""""""""""""""""""
  let g:NERDTreeHijackNetrw = 0

  """""""""""""""""""""""""
  " dbext.vim             "
  """""""""""""""""""""""""
  " Disable all default key mappings
  let g:dbext_default_usermaps = 0

  """""""""""""""""""""""""
  " buftabs.vim           "
  """""""""""""""""""""""""
  let g:buftabs_only_basename = 1
  "let g:buftabs_in_statusline = 1

  """""""""""""""""""""""""
  " DrawItPlugin.vim      "
  """""""""""""""""""""""""
  map <unique> \di <Plug>StartDrawIt
  map <unique> \ds <Plug>StopDrawIt
  let g:DrChipTopLvlMenu = "Plugin."

  """""""""""""""""""""""""
  " cmdline-complete.vim  "
  """""""""""""""""""""""""
  " Nothing to change

  """""""""""""""""""""""""
  "                       "
  """""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""
" Load more
""""""""""""""""""""""""""""""""""""""""""""""""""

let local_vimrc = os == win ? '$VIM\local_vimrc' : '~/.vimrc_local'

if filereadable(expand(local_vimrc))
  exe 'source' local_vimrc
endif




