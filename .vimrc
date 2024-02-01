set enc=utf-8
scriptencoding utf-8
set termencoding=utf-8
" Doesn't seem to help:
set ttyfast
set lazyredraw
set regexpengine=1

" Escape without ESC
set ttimeout
set ttimeoutlen=50
" The timeout (single T) is for maps and must remain longer
inoremap jk <Esc>
inoremap kj <Esc>

" File I/O
"
set dir=/tmp        " Don't abuse the SSD, sshfs, etc.
set backupcopy=yes  " However, preserve extended file attributes (slower)
set autoread        " Keep up with outside changes
set ssop-=options   " do not store global and local values in a session
set ssop-=folds     " do not store folds
" Try to save modified buffers when they go out of sight or we quit
" (You do NOT need to set 'hidden' with these.)
set autowriteall
au FocusLost * silent! update
" Writes to tmp file at this frequency.
" Default: 4000
" Reduced because:
" 1. We're in /tmp/ which is tmpfs
" 2. Accelerates feedback from Gitgutter
set updatetime=1000


" Plugins
"
set laststatus=2
set noshowmode
if filereadable(expand("$HOME/.vim/plugins.vim"))
	source $HOME/.vim/plugins.vim
endif


" 256 color theme
"
set termguicolors
" XXX what did I use the following for?
set t_ut=
if &term =~# '^tmux'
	let &t_8f = "\e[38;2;%lu;%lu;%lum"
	let &t_8b = "\e[48;2;%lu;%lu;%lum"
endif
"colorscheme koehler
"colorscheme molokai
"set background=dark
colorscheme lisvscode

" Distinguish insert mode
"
" Cursor:
" 0 -> blinking block
" 1 -> blinking block (default)
" 2 -> steady block
" 3 -> blinking underline
" 4 -> steady underline
" 5 -> blinking bar (xterm)
" 6 -> steady bar (xterm)
let &t_SI = "\e[6 q"  "Insert
let &t_EI = "\e[2 q"  "Command
silent execute "!echo -ne '" . escape("\033]12;#ff8800\7", "%#!") . "'"
" reset cursor when vim exits
autocmd VimLeave * silent !echo -ne "\033]112\007"

" Cursor line:
:set nocul
:au InsertEnter * set cul
:au InsertLeave * set nocul
" Very important to keep it off in command mode because it is a performance hog.
" Change Color when entering Insert Mode
" au InsertEnter * hi CursorLine guibg=#e0f0ff
" Revert Color to default when leaving Insert Mode
" au InsertLeave * hi CursorLine guibg=#ebebeb

" Layout
"
set noflash
" set modeline
set title
set ruler
set showcmd
set number
set scrolloff=3
set sidescrolloff=12
set showtabline=2
let g:lightline = {
			\ 'component': {
			\   'readonly': '%{&readonly?"🚫":""}',
			\ },
			\ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
			\ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
			\ }
" Maybe create our own bufferline?
" See: https://github.com/itchyny/lightline.vim/issues/43#issuecomment-37011534
" He does it for tabs, but bufnr() and co. can do the trick for buffers.
let g:lightline.tabline = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type = {'buffers': 'tabsel'}
let g:lightline#bufferline#modified = ' 💡'
let g:lightline#bufferline#read_only = ' 🚫'
let g:lightline#bufferline#unnamed = 'untitled'
" Uses pathshorten() from Vim which is sadly inadequate compared to VScode's
" We might have to write our own to only show key differences.
let g:lightline#bufferline#filename_modifier = ':~:.'
let g:lightline#bufferline#shorten_path = '1'

" Other behavior
"
set backspace=indent,eol,start
set nospell
let loaded_matchparen=1
set wildmenu
set wildmode=list:longest
" Jump to the last position when reopening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" Clean up after closing quick fix window
au QuickFixCmdPost l* redraw! | lwindow
au QuickFixCmdPost [^l]* redraw! | cwindow
" Side-by-side diff
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
" Yank to system CLIPBOARD and PRIMARY
set clipboard=unnamed,unnamedplus,exclude:cons\|linux
let g:tagbar_sort = 0
let g:gutentags_ctags_tagfile = ".tags"
let g:gutentags_ctags_exclude = ['node_modules', 'vendor']


" Searching
"
set hlsearch
set incsearch
set ignorecase
set smartcase
set noshowmatch  " buggy with '}}' per https://github.com/vim/vim/issues/437
runtime macros/matchit.vim


" Folding
"
set foldmethod=indent  " Of course Perl isn't supported, *sigh*
set foldcolumn=1
set nofoldenable
set foldlevel=25


" File explorer
"
" (The thing's so buggy that it's best to stick with defaults.)
let g:netrw_banner = 0
set fillchars+=vert:│
" Netrw seems to open in the current buffer's directory EVEN WITHOUT this.
" Disabling autochdir makes lightline-bufferline's shortened paths tolerable.
"set autochdir
autocmd FileType netrw setl bufhidden=wipe

" FZF
" Adapted from https://github.com/junegunn/fzf/issues/2687
function! MyFiles()
	let path = trim(system('cd '.shellescape(expand('%:p:h')).' && git rev-parse --show-toplevel'))
	if !isdirectory(path)
		let path = expand('%:p:h')
	endif
	exe 'Files ' . path
endfunction
command! MyFiles call MyFiles()


" Handy commands
"
command -range=% SortIP <line1>,<line2>!sort -n -t . -k 1,1 -k 2,2 -k 3,3 -k 4,4

" My custom inputs
"
set mouse=nvi
set ttymouse=sgr
" Since undo is 'u', let's make redo 'U'
map U :redo<cr>
" Split edits
map <C-E> :split<cr>
map <C-R> :wincmd p<cr>
map <C-T> :hide<cr>
" Basic tab/buffer navigation
map <C-PageUp> :bprevious<cr>
map <C-PageDown> :bnext<cr>
map [5;5~ :bprevious<cr>
map [6;5~ :bnext<cr>
map <C-W> :bd<cr>
" File explorer
map + :Explore<cr>
map = :MyFiles<cr>
map  :%s/
map!  /cg
map  :%&cg
" map!  :s/./_\b&/g\i
" map!  :s/./&\b&/g\i
" Numeric keypad (disabled after moving to a laptop)
"map! Op 0
"map! On .
"map! Oq 1
"map! Or 2
"map! Os 3
"map! Ot 4
"map! Ou 5
"map! Ov 6
"map! Ow 7
"map! Ox 8
"map! Oy 9
"map! Ok +
"map! Oo /
"map! Oj *
"map! Om -


" Default formatting
"
set nowrap
set formatoptions=roql
"filetype plugin indent on
set autoindent
set smartindent
set smarttab
set tabstop=4
set noexpandtab
set shiftwidth=4
set textwidth=80
syntax off
set synmaxcol=120

" Omni
"
:set completeopt=menuone,preview,longest
" Auto-close omni preview window when we leave the menu
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif

" Local configuration files
"
" Plug 'embear/vim-localvimrc' caused 100% CPU usage on tab switches, so doing
" this manually at startup only.
"
" Development
if stridx(getcwd(), expand('~/src')) == 0
	source ~/src/.vimrc
endif
" GraphX
if stridx(getcwd(), expand('~/src/graphx')) == 0
	source ~/src/graphx/.vimrc
endif

" Additional highlighting
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
set list
set listchars=tab:│\ ,nbsp:⎵
highlight SpecialKey ctermfg=lightgray guifg=lightgray

" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line
" ## added by OPAM user-setup for vim / ocp-indent ## 069fbb917b55952c530d38de8a07fa52 ## you can edit, but keep this line
if count(s:opam_available_tools,"ocp-indent") == 0
  source "/home/lis/.opam/4.13.1+muslnative+flambda/share/ocp-indent/vim/indent/ocaml.vim"
endif
" ## end of OPAM user-setup addition for vim / ocp-indent ## keep this line
