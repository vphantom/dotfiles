call plug#begin('~/.vim/plugged')

" Local .lvimrc files
"
" Slows tab switching to a crawl at 100% CPU
"Plug 'embear/vim-localvimrc'

" Friendlier sessions
"
"Plug 'tpope/vim-obsession'

" Status bar
"
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'

" Scroll bar
"
" Doesn't follow scroll, removes gitgutter & co! :(
"Plug 'lornix/vim-scrollbar'
Plug 'gcavallanti/vim-noscrollbar'

" Git
"
Plug 'airblade/vim-gitgutter'
"Plug 'tpope/vim-fugitive'

" Interactive syntax check
"
Plug 'w0rp/ale'

" Markdown live preview
Plug 'iamcco/markdown-preview.vim'

" Languages
"
"Plug 'ekalinin/Dockerfile.vim'
Plug 'tpope/vim-markdown'
Plug 'pangloss/vim-javascript'
"BUNDLE reasonml-editor/vim-reason ???
Plug 'ap/vim-css-color'

" Editing
"
" Auto-close parenthesis, brackets, quotes
Plug 'Raimondi/delimitMate'
" Rebuild tags quietly
"Plug 'ludovicchabant/vim-gutentags' HIGH CPU CONSUMPTION
Plug 'tomtom/tcomment_vim'
"Plug 'tpope/vim-surround'
Plug 'Yggdroot/indentLine'
Plug 'majutsushi/tagbar'

" Different syntax for a portion of a file
"
" (Unfortunately this is ephemeral, but better than nothing.)
Plug 'inkarkat/vim-ingo-library'
Plug 'inkarkat/vim-SyntaxRange'
Plug 'inkarkat/vim-SearchHighlighting'

" Code formatter
"
" What does this offer that ALEFix doesn't?
"Plug 'Chiel92/vim-autoformat'
"
" Rainbow parenthesis
" (BREAKS SYNTAX HIGHLIGHTING in OCaml)
"Plug 'kien/rainbow_parentheses.vim'

call plug#end()
