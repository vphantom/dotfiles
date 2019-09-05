scriptencoding utf-8
set termencoding=utf-8

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
" Change Color when entering Insert Mode
" au InsertEnter * hi CursorLine guibg=#e0f0ff
" Revert Color to default when leaving Insert Mode
" au InsertLeave * hi CursorLine guibg=#ebebeb

" Layout
"
set noflash
set modeline
set title
set ruler
set showcmd
set number
set scrolloff=3
set sidescrolloff=12
set showtabline=2
let g:lightline = {
			\ 'component_function': {
			\   'percent': 'noscrollbar#statusline'
			\ },
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


" Searching
"
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch  " buggy with '}}' per https://github.com/vim/vim/issues/437
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


" My custom inputs
"
set mouse=nvi
set ttymouse=sgr
set timeoutlen=1000 ttimeoutlen=0
" Escape without ESC
inoremap jk <Esc>
inoremap kj <Esc>
" Basic tab/buffer navigation
map <C-PageUp> :bprevious<cr>
map <C-PageDown> :bnext<cr>
map [5;5~ :bprevious<cr>
map [6;5~ :bnext<cr>
map <C-W> :bd<cr>
" File explorer
map = :Explore<cr>
" Tag explorer
map - :TagbarOpenAutoClose<cr>
" Reset highlight: complement to '*' and search results
map <leader>8 :noh<cr>
map  :%s/
map!  /cg
map  :%&cg
map!  :s/./_\b&/gi
map!  :s/./&\b&/gi
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
set textwidth=132
syntax on
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
set list
set listchars=tab:│\ ,nbsp:⎵
highlight SpecialKey ctermfg=lightgray guifg=lightgray
" The indentLine plugin adds similar pipes for space identations, although invisible in the cursorline.
let g:indentLine_char = '│'
let g:indentLine_color_term = 250
let g:indentLine_color_gui = "#cccccc"
let g:indentLine_concealcursor = ''
" Comment keyword highlights
" Thanks to: https://vi.stackexchange.com/a/15531
highlight clear Todo
highlight link Todo Comment
augroup myTodos
	autocmd!
	autocmd Syntax * syntax match myHlCritical  /\v\c\_.<(FIXME:?|BUG:)/hs=s+1 containedin=.*Comment contained
	autocmd Syntax * syntax match myHlNote      /\v\c\_.<XXX:?/hs=s+1 containedin=.*Comment contained
	autocmd Syntax * syntax match myHlUrgent    /\v\c\_.<TODO:?/hs=s+1 containedin=.*Comment contained
	autocmd Syntax * syntax match myHlImportant /\v\c\_.<HACK:/hs=s+1 containedin=.*Comment contained
	autocmd Syntax * syntax match myHlCool      /\v\c\_.<NOTE:/hs=s+1 containedin=.*Comment contained
augroup END
highlight myHlCritical ctermfg=white guifg=white ctermbg=red guibg=#dd0000
highlight myHlNote ctermfg=white guifg=white ctermbg=red guibg=#2266ff
highlight myHlUrgent ctermfg=black guifg=black ctermbg=red guibg=#ff8800
highlight myHlImportant ctermfg=black guifg=black ctermbg=red guibg=#eecc00
highlight myHlCool ctermfg=black guifg=black ctermbg=red guibg=#77dd77


" Omni
"
" Auto-close omni preview window when we leave the menu
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif


" Language-specific
"
au Filetype ocaml setlocal tabstop=2 expandtab shiftwidth=2 textwidth=80 formatoptions-=r
au Filetype markdown setlocal wrap formatoptions-=tcq
let g:javascript_plugin_jsdoc = 1
let g:markdown_fenced_languages = ['css', 'html', 'ini=dosini', 'sh', 'perl', 'ocaml', 'js=javascript', 'sexp=scheme']
let perl_include_pod = 1
" My only use of Template::Toolkit uses non-standard tags
let b:tt2_syn_tags = '{{ }}'


" My special paths
"
" Unfortunately, plugin https://github.com/embear/vim-localvimrc slows buffer switching to a crawl at 100% CPU.
au BufRead,BufNewFile ~/devel/graphx/merino-docker/www/*/html/* set ft=mason
au BufRead,BufNewFile ~/devel/graphx/merino-docker/www/*/web/templates/* set ft=tt2html


" ALE
"
filetype off
let &runtimepath.='~/.vim/plugged/ale'
let g:ale_sign_column_always = 1
let g:ale_sign_error = '⛔'
highlight ALEErrorSign ctermfg=white guifg=white ctermbg=10 guibg=#ebebeb
let g:ale_sign_warning = '🔔'
highlight ALEWarningSign ctermfg=white guifg=white ctermbg=10 guibg=#ebebeb
highlight SpellBad ctermbg=10 guibg=#ffe0e8
highlight SpellCap ctermbg=10 guibg=#e0f0ff
let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 'normal'
"let g:ale_linters_explicit = 1
"let g:ale_linters = {
"			\'ocaml': ['ols'],
"			\}
let g:ale_fixers = {
			\'javascript': ['prettier'],
			\'css': ['prettier'],
			\'json': ['jq'],
			\'ocaml': ['ocamlformat'],
			\'reason': ['refmt'],
			\}
"let g:ale_javascript_prettier_options = '--single-quote --trailing-comma es5'
"let g:ale_javascript_prettier_options = '--tab-width=4 --use-tabs'
let g:ale_javascript_prettier_options = '--single-quote'
let g:ale_css_prettier_options = '--tab-width=4 --use-tabs'
" TODO: JS, I get eslint warnings yet it says Prettier only above, wtf?
" TODO: Reason ?
" TODO: Perl, do we bother? Would perl-critic help catch bugs or juts formatting?
filetype plugin on


" Git
"
let g:gitgutter_sign_added = '++'
let g:gitgutter_sign_modified = '**'
let g:gitgutter_sign_modified_removed = '*-'
let g:gitgutter_sign_removed = '--'
let g:gitgutter_sign_removed_first_line = '^^'  " Unused?!?
highlight GitGutterAdd ctermfg=black guifg=black ctermbg=green guibg=#afdf00
highlight GitGutterChange ctermfg=black guifg=black ctermbg=blue guibg=#87dfff
highlight GitGutterChangeDelete ctermfg=black guifg=black ctermbg=blue guibg=#87dfff
highlight GitGutterDelete ctermfg=white guifg=white ctermbg=red guibg=#df2f50

" I wanted undercurls, but they are still not merged in Vim as of 2019-01-25
"
" Neovim's latest seems to support it?
" Tmux 2.9 seems to support it per https://github.com/tmux/tmux/issues/1492
"
"set t_Ce="\e[4:0m\e[59m"
"set t_Cs="\e[4:3m\e[58;5;9m"
"highlight SpellBad gui=undercurl cterm=undercurl guisp=Red guibg=NONE
"highlight SpellCap gui=undercurl cterm=undercurl guisp=Blue guibg=NONE


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
