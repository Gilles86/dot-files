set runtimepath^=~/.nvim runtimepath+=~/.nvim/after
let &packpath = &runtimepath
if empty(glob('~/.nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" VSCode extension
if exists('g:vscode')

    call plug#begin('~/.config/nvim/plugged')
        Plug 'tpope/vim-surround'
        Plug 'tpope/vim-repeat'

    call plug#end()

	nnoremap W :Write<cr>
	nnoremap Q :Quit!<cr>
	nmap E <C-p>
	nmap w <C-W>

	xmap gc  <Plug>VSCodeCommentary
	nmap gc  <Plug>VSCodeCommentary
	omap gc  <Plug>VSCodeCommentary
	nmap gcc <Plug>VSCodeCommentaryLine
	
	nnoremap K  :<C-u>call VSCodeCall('editor.action.showHover')<CR>
	nnoremap wc :<C-u>call VSCodeCall('workbench.action.closeEditorsAndGroup')<CR>
	nnoremap <space>x :<C-u>call VSCodeCall('workbench.view.extensions')<CR>
	nnoremap <space>e :<C-u>call VSCodeCall('workbench.view.explorer')<CR>

	nnoremap ? :<C-u>call VSCodeCall('workbench.action.findInFiles', { 'query': expand('<cword>')})<CR>

    function! HighlightWord()
        let line=line('.')
        let cword = expand("<cword>")
        call matchadd('HighlightWord', cword, 50)
    endfunction
    nnoremap ) :call HighlightWord()<cr>
    nnoremap ( :nohl<cr>:call clearmatches()<cr>
else
	" Normal neo vim
endif
