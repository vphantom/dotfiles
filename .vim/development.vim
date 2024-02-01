" Stuff I only want in development

syntax on

" Tag explorer
map - :TagbarOpenAutoClose<cr>

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

" Codeium
"
" Override defaults to play nice with omnicompletion.
"
" Based on:
" https://gist.github.com/limitedeternity/9349aae07dac6bea191aa97949633990
function! HasCodeiumCompletion() abort
	return exists('b:_codeium_completions') &&
		\ has_key(b:_codeium_completions, 'items') &&
		\ has_key(b:_codeium_completions, 'index') &&
		\ len(b:_codeium_completions['items']) > 0
endfunction
function! SmartTab() abort
	if HasCodeiumCompletion()
		return codeium#Accept()
	endif
	if pumvisible()
		return "\<C-Y>"
	endif
	if strpart(getline('.'), 0, col('.') - 1) =~ '^\s*$'
		return "\<Tab>"
	endif
	if has("autocmd") && exists("+omnifunc")
		return "\<C-X>\<C-O>"
	endif
	return "\<Tab>"
endfunction
function! SmartBackspace() abort
	if HasCodeiumCompletion()
		return codeium#Clear()
	endif
	return "\<BS>"
endfunction
function! SmartPageUp() abort
	if HasCodeiumCompletion()
		call codeium#CycleCompletions(-1)
		return ""
	endif
	return "\<PageUp>"
endfunction
function! SmartPageDown() abort
	if HasCodeiumCompletion()
		call codeium#CycleCompletions(1)
		return ""
	endif
	return "\<PageDown>"
endfunction
let g:codeium_disable_bindings = 1
inoremap <silent><expr> <Tab> SmartTab()
inoremap <silent><expr> <BS> SmartBackspace()
inoremap <silent><expr> <PageUp> SmartPageUp()
inoremap <silent><expr> <PageDown> SmartPageDown()
" To disable by default and ask explicitly for suggestions:
" let g:codeium_manual = v:true
" imap <S-Tab> <Cmd>call codeium#Complete()<cr>
" imap <F12> <Cmd>call codeium#Complete()<cr>
"
" Lightline status
let g:lightline.component.percent = "\{…\}%3{codeium#GetStatusString()}"


" Language-specific
"
au Filetype ocaml setlocal tabstop=2 expandtab shiftwidth=2 textwidth=80 formatoptions-=r
au Filetype proto setlocal tabstop=2 expandtab shiftwidth=2 textwidth=80
let g:merlin_completion_with_doc = 1
au Filetype markdown setlocal wrap formatoptions-=tcq
let g:javascript_plugin_jsdoc = 1
let g:markdown_fenced_languages = ['css', 'html', 'ini=dosini', 'sh', 'perl', 'ocaml', 'js=javascript', 'sexp=scheme']
let perl_include_pod = 1

" ALE
"
filetype off
let &runtimepath.='~/.vim/plugged/ale'
" Virtualtext INJECTS TEXT! breaks parsing and adds nothing vs status area.
let g:ale_virtualtext_cursor = 0
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
 let g:ale_linters = {
 			\'javascript': ['eslint'],
 			\'perl': ['perl','perlcritic'],
 			\'python': ['flake8'],
 			\}
"let g:ale_javascript_eslint_options = "--rule 'camelcase:off' --rule 'key-spacing:off' --rule 'quotes:off' --rule 'indent:[2,tab]' --rule 'max-statements:off'"
let g:ale_fixers = {
			\'c': ['clang-format'],
			\'css': ['prettier'],
			\'javascript': ['prettier_eslint'],
			\'json': ['jq'],
			\'ocaml': ['ocamlformat'],
			\'python': ['black'],
			\'scss': ['prettier'],
			\}
" JS
"let g:ale_javascript_prettier_eslint_options = "--use-tabs --tab-width=4 --single-quote --trailing-comma=es5"
" CSS
"let g:ale_javascript_prettier_options = '--use-tabs --tab-width=4 --trailing-comma=es5'
" OCaml
let g:ale_ocaml_ocamlformat_options = '--enable-outside-detected-project'
filetype plugin on
map <leader>w :ALENextWrap<cr>


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
map <leader>s :let @g = system("git blame -c -L " . line(".") . ",+1 " . expand("%"))<cr>:echomsg @g<cr>
"map <leader>s :Gblame<cr>
map <leader>g :GitGutterNextHunk<cr>

" I wanted undercurls, but they are still not merged in Vim as of 2019-01-25
"
" Neovim's latest seems to support it?
" Tmux 2.9 seems to support it per https://github.com/tmux/tmux/issues/1492
"
"set t_Ce="\e[4:0m\e[59m"
"set t_Cs="\e[4:3m\e[58;5;9m"
"highlight SpellBad gui=undercurl cterm=undercurl guisp=Red guibg=NONE
"highlight SpellCap gui=undercurl cterm=undercurl guisp=Blue guibg=NONE

