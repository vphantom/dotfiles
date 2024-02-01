call plug#begin('~/.vim/plugged')

" ATTENTION!
"
" Since upgrading to Vim 9 via AppImage I can no longer let Plug use Git on its
" own because of incorrect SSL environment settings.  Instead, you have to run
" 'git clone --depth=1 ...' manually before running PlugInstall.


"" GENERAL

" FZF
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Status bar
"
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'

" Show indentation even for spaces
Plug 'Yggdroot/indentLine'   " Might slow things down?

" Inkarkat plugins
Plug 'inkarkat/vim-ingo-library'
" Improve * command
Plug 'inkarkat/vim-SearchHighlighting'


"" DEVELOPMENT
if stridx(getcwd(), expand('~/src')) == 0

	" Codeium
	"
	" AI context-aware code completion
	Plug 'Exafunction/codeium.vim', { 'branch': 'main' }

	" Git
	"
	Plug 'airblade/vim-gitgutter'

	" Interactive syntax check
	"
	Plug 'w0rp/ale'

	" Languages
	"
	"Plug 'ekalinin/Dockerfile.vim'
	Plug 'tpope/vim-markdown'
	Plug 'pangloss/vim-javascript'  " Still necessary?
	Plug 'ap/vim-css-color'

	" Editing
	"
	" Rebuild tags quietly (VERY HIGH CPU CONSUMPTION!)
	Plug 'ludovicchabant/vim-gutentags'
	Plug 'majutsushi/tagbar'
	" Better comments
	Plug 'tpope/vim-commentary'
	"Plug 'tpope/vim-surround'   " I never use this?
	" Doesn't do much with our structure, but slightly better than nothing:
	Plug 'c9s/perlomni.vim'

endif  " DEVELOPMENT

call plug#end()
