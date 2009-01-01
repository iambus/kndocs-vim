"
" For Kneo
"
"
"
"
"





"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Platform
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! MySys()
  return "linux"
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Get out of VI's compatible mode..
set nocompatible

"Sets how many lines of history VIM har to remember
set history=400

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key bindings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Set mapleader
let mapleader = ","
"let g:mapleader = ","

"Fast saving
"nmap <leader>w :w!<cr>
"nmap <leader>f :find<cr>


map <leader>W :w! ~/tmp/_<cr>
map <leader>h :help<space>
map <leader>K :exe "help" expand("<cword>")<cr>
map <leader>cd :cd %:p:h<cr>

map \rc :e ~/.vimrc<cr>
map \sorc :source ~/.vimrc<cr>

map \msn i<c-r>=strftime("%Y-%m-%d %H:%M")<cr> MSN<cr>

" Disable alt menu keys
set winaltkeys=no

map <M-y> "+yy
map <M-Y> gg"+yG<C-O><C-O>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Enable syntax hl
syntax enable

"Set font
if MySys() == "mac"
  set gfn=Bitstream\ Vera\ Sans\ Mono:h14
  set nomacatsui
  set termencoding=macroman
elseif MySys() == "linux"
  set gfn=Monospace\ 11
endif

if has("gui_running")
"  set guioptions-=T
  let psc_style='cool'
  set background=dark
"  colorscheme ps_color
  colorscheme moria
else
"  set background=dark
"  colorscheme zellner
  colorscheme darkblue
endif

"Highlight current
"if has("gui_running")
"  set cursorline
"  hi cursorline guibg=#feddfc
"  hi CursorColumn guibg=#feddfc
"else
"  set cursorline
"  hi cursorline term=reverse
"  hi cursorline ctermbg=7
"  hi cursorline cterm=none
"endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fileformats
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Favorite filetypes
set ffs=unix,dos,mac

nmap <leader>fd :se ff=dos<cr>
nmap <leader>fu :se ff=unix<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fileencodings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set fileencodings=utf-8,gbk,ucs-bom,default,latin1
"nmap <leader>eu :e enc=utf-8<cr>
"nmap <leader>eg :e enc=gbk<cr>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM userinterface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Set 7 lines to the curors - when moving vertical..
set so=7

"Turn on WiLd menu
set wildmenu

"Always show current position
set ruler

"The commandbar is 2 high
"set cmdheight=2

"Show line number
set nu

"Do not redraw, when running macros.. lazyredraw
set lz

"Change buffer - without saving
set hid

"Set backspace
set backspace=eol,start,indent

"Bbackspace and cursor keys wrap to
set whichwrap+=<,>,h,l

"Ignore case when searching
set ignorecase
set incsearch

"Set magic on
set magic

"No sound on errors.
set noerrorbells
set novisualbell
set t_vb=

"show matching bracets
set showmatch

"How many tenths of a second to blink
set mat=2

"Highlight search things
set hlsearch

set showcmd

  """"""""""""""""""""""""""""""
  " Statusline
  """"""""""""""""""""""""""""""
  "Always hide the statusline
  set laststatus=2

  function! CurDir()
    let curdir = substitute(getcwd(), '/home/pleiades/', "~/", "g")
    return curdir
  endfunction

  "Format the statusline
  set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Buffer realted
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Restore cursor to file position in previous editing session
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif





"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Files and backups
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Turn backup off
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Enable folding, I find it very useful
"set nofen
"set fdl=0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set tabstop=4
set shiftwidth=4

map <leader>t2 :set shiftwidth=2<cr>
map <leader>t3 :set shiftwidth=3<cr>
map <leader>t4 :set shiftwidth=4<cr>
map <leader>tt :set shiftwidth=4<cr>:set noexpandtab<cr>

set smarttab
set lbr
set tw=500

  """"""""""""""""""""""""""""""
  " Indent
  """"""""""""""""""""""""""""""
  "Auto indent
  set ai

  "Smart indet
  set si

  "C-style indeting
  "set cindent

  "Wrap lines
  set wrap


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tab Mapping
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetype generic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  "Add comments - not good
  " ,ct  comment
  "

  "autocmd FileType c,cpp,java map <leader>ct <ESC>0i//<ESC>
  "autocmd FileType perl,python,tclsh map <leader>ct <ESC>0i#<ESC>

  "Set filetype
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

  "Set more filetype
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

  map \61 :set filetype=sh<cr>
  map \62 :set filetype=dosbatch<cr>

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
  "autocmd FileType vim set nofen

  """"""""""""""""""""""""""""""
  " C mappings
  """""""""""""""""""""""""""""""
"  autocmd FileType c map <buffer> <leader>cc :up<cr>:!gcc -W -Wall %<cr>
  autocmd FileType c map <buffer> <leader>cc :up<cr>:exe "!gcc -W -Wall % -o ".FileDir().'/a.out'<cr>
  autocmd FileType c map <buffer> <leader>cr :up<cr>:exe '!'.FileDir().'/a.out'<cr>
  autocmd FileType c map <buffer> <leader><space> <leader>cc

  """"""""""""""""""""""""""""""
  " C++ mappings
  """""""""""""""""""""""""""""""
"  autocmd FileType cpp map <buffer> <leader>cc :up<cr>:!g++ -W -Wall %<cr>
  autocmd FileType cpp map <buffer> <leader>cc :up<cr>:exe "!g++ -W -Wall % -o ".FileDir().'/a.out'<cr>
  autocmd FileType cpp map <buffer> <leader>cr :up<cr>:exe '!'.FileDir().'/a.out'<cr>
  autocmd FileType cpp map <buffer> <leader><space> <leader>cc

  """"""""""""""""""""""""""""""
  " C/C++
  """""""""""""""""""""""""""""""
  autocmd FileType c,cpp map <buffer> <leader>= :up<cr>:%!astyle --style=ansi -p < %<cr>

  """""""""""""""""""""""""""""""
  " Java section
  """""""""""""""""""""""""""""""


  """""""""""""""""""""""""""""""
  " Perl section 
  """""""""""""""""""""""""""""""
  autocmd FileType perl map <buffer> <leader><space> :up<cr>:!perl %<cr>
  autocmd FileType perl map <buffer> <leader>cc :up<cr>:!perl -c %<cr>


  """""""""""""""""""""""""""""""
  " Python section
  """""""""""""""""""""""""""""""
  autocmd FileType python map <buffer> <leader><space> :up<cr>:!python %<cr>


  """""""""""""""""""""""""""""""
  " Tcl section
  """""""""""""""""""""""""""""""
  autocmd FileType tcl map <buffer> <leader><space> :up<cr>:!tclsh %<cr>


  """""""""""""""""""""""""""""""
  " Lua section
  """""""""""""""""""""""""""""""
  autocmd FileType lua map <buffer> <leader><space> :up<cr>:!lua %<cr>


  """""""""""""""""""""""""""""""
  " Lisp section
  """""""""""""""""""""""""""""""
  autocmd FileType lisp map <buffer> <leader><space> :up<cr>:!clisp %<cr>


  """""""""""""""""""""""""""""""
  " XML section
  """""""""""""""""""""""""""""""
  autocmd FileType xml map <buffer> <leader>= :up<cr>:%!xmllint --format %<cr>
  autocmd FileType xml map <buffer> <leader><space> <leader>=


  """""""""""""""""""""""""""""""
  " JavaScript
  """""""""""""""""""""""""""""""
  autocmd FileType javascript map <buffer> <leader><space> :up<cr>:!js %<cr>

  """""""""""""""""""""""""""""""
  " HTML
  """""""""""""""""""""""""""""""
  autocmd FileType html map <buffer> <leader>= :up<cr>:%!tidy -f /dev/null %<cr>

  """""""""""""""""""""""""""""""
  " 
  """""""""""""""""""""""""""""""



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




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Load more
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if filereadable(expand('~/.vimrc_local'))
  source ~/.vimrc_local
endif


