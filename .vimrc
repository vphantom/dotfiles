" Don't abuse the SSD, sshfs, etc.
:set dir=/tmp
" However, preserve extended file attributes (slower)
:set backupcopy=yes
":set mouse=a
":set ttymouse=xterm2
:set title
:set noflash
:set ruler
:set noexpandtab
:set shiftwidth=3
:let loaded_matchparen=1
:set showmatch
:set showmode
:set showcmd
:set hidden
:set tabstop=3
:set nowrap
:set textwidth=78
:set formatoptions=roql
:set foldmethod=marker
:set foldmarker={,}
:set nofoldenable 
:highlight Folded ctermbg=black ctermfg=blue
:highlight FoldColumn ctermbg=black ctermfg=white
:filetype plugin indent on
:set autoindent
:runtime macros/matchit.vim
" Auto-close omni preview window when we leave the menu
:au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
syntax on
:set background=dark
:set incsearch
:set wildmenu
:set wildmode=list:longest
:set ignorecase
:set smartcase
:set scrolloff=3
:set sidescrolloff=12
:let Tlist_Inc_Winwidth=0
:let Tlist_GainFocus_On_ToggleOpen=1
:let Tlist_Sort_Type="name"
:let Tlist_Close_On_Select=1
:let Tlist_Compact_Format=1
:let Tlist_Exit_OnlyWindow=1
" :map  {j0dwvipJ0jj
:map  :TlistOpen
:map!  :TlistOpeni
:map Q gqap
:map!  gqapi
:map  dd
:map!  ddi
:map!  ui
:map  :%s/
:map!  /cg
:map  :%&cg
:map!  :s/./_\b&/gi
:map!  :s/./&\b&/gi
:map  %
:map!  %i
:map! Op 0
:map! On .
:map! Oq 1
:map! Or 2
:map! Os 3
:map! Ot 4
:map! Ou 5
:map! Ov 6
:map! Ow 7
:map! Ox 8
:map! Oy 9
:map! Ok +
:map! Oo /
:map! Oj *
:map! Om -
:com DiffOrig vert new | se bt=nofile | r # | 0d_ | difft | winc p | difft
:set modeline
:set modelines=100
:set ssop-=options    " do not store global and local values in a session
:set ssop-=folds      " do not store folds
:au fileType * setlocal formatoptions-=c
:au fileType javascript,php au BufWritePost <buffer> silent make
:au fileType javascript setlocal makeprg=eslint\ --format\ unix\ % expandtab tabstop=2 shiftwidth=2 softtabstop=2
:au fileType php setlocal makeprg=phpcs\ --report=emacs\ --standard=PEAR\ --tab-width=4\ --ignore=smarty,tpl_c\ -n\ % expandtab tabstop=4 shiftwidth=4 softtabstop=4
:au QuickFixCmdPost l* redraw! | lwindow
:au QuickFixCmdPost [^l]* redraw! | cwindow
:let g:localvimrc_persistent=2
:let g:localvimrc_event=["BufWinEnter","BufReadPre","BufNewFile"]
