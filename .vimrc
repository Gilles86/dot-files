" Install Vim Plug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif



call plug#begin('~/.vim/plugged')
   Plug 'sheerun/vim-polyglot'

   Plug 'hail2u/vim-css3-syntax'
   Plug 'ervandew/supertab'
   Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' }

   Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
   Plug 'junegunn/fzf.vim'

   Plug 'vim-airline/vim-airline'
   Plug 'crusoexia/vim-monokai'
   Plug 'scrooloose/nerdtree'

   Plug 'tpope/vim-commentary'
   Plug 'tpope/vim-surround'
   Plug 'tpope/vim-fugitive'
   Plug 'tpope/vim-repeat'
   Plug 'tpope/vim-unimpaired'

   Plug 'vim-scripts/perl-support.vim'

call plug#end()

" -------------------------------------
"  Configurations
" -------------------------------------
set scrolloff=7
set foldlevel=99
set foldmethod=syntax
set numberwidth=2
set wrap
set linebreak
set shiftwidth=4
set tabstop=4
set expandtab
set background=dark
set hidden
set hlsearch
set ignorecase
set smartcase
set encoding=utf-8
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap gj j
nnoremap gk k
vnoremap gj j
vnoremap gk k
syntax enable
filetype plugin on
let g:solarized_termcolors=256
let g:netrw_banner=0
au BufNewFile,BufRead *.es6 set filetype=javascript
au BufNewFile,BufRead *.vash set filetype=html
au BufNewFile,BufRead *.tt set filetype=html
au BufNewFile,BufRead *.css,*.scss,*.less setlocal foldmethod=marker foldmarker={,}
" au BufNewFile,BufRead *.js set filetype=typescript
" set diffopt+=vertical

" -------------------------------------
"  crusoexia/vim-monokai
" -------------------------------------
syntax on
colorscheme default
set t_Co=256
set path+=**
set wildmenu
highlight Normal ctermbg=232
highlight Search cterm=NONE ctermfg=214 ctermbg=236
highlight YcmErrorLine ctermbg=233 ctermfg=204
highlight YcmErrorSection ctermbg=236 ctermfg=196
highlight ColorColumn ctermbg=238 
highlight Error ctermbg=233 ctermfg=204
highlight Visual term=reverse cterm=reverse guibg=Grey
call matchadd('ColorColumn', '\%81v', 100)

" -------------------------------------
"  Mappings
" -------------------------------------
nmap w <C-W>
nnoremap W :w<cr>
nnoremap Q :bw<cr>
nnoremap Z <c-z>
nnoremap L :bnext<cr>
nnoremap H :bprev<cr>
nnoremap K :YcmCompleter GetType<cr>
nnoremap =% :Neoformat<cr>
autocmd FileType c,cpp map <buffer> gD :YcmCompleter GoToDefinition<cr>
autocmd FileType c,cpp map <buffer> gd :YcmCompleter GoToDeclaration<cr>
autocmd FileType c,cpp map <buffer> gF :YcmCompleter GoToInclude<cr>

nnoremap [* :Ggrep <cword> --<CR><CR>:copen<CR>
nnoremap ]* *``:Ggrep <cword> --<CR><CR>
nnoremap <C-n> :noh<cr>
map <space> <leader>
nnoremap <leader><space> :NERDTreeFind %<CR>
"tnoremap <esc><esc> <C-\><C-n>
cnoremap J <down>
cnoremap K <up>
cnoremap jjj J
cnoremap kkk K
cnoremap Noh noh

" -------------------------------------
"  FZF
" -------------------------------------
nnoremap <c-p> :GFiles<cr>
nnoremap E :Files<cr>

" -------------------------------------
"  YouCompleteMe
" -------------------------------------
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_always_populate_location_list = 1
let g:ycm_auto_trigger=1
let g:ycm_confirm_extra_conf = 0
let g:ycm_enable_diagnostic_highlighting=1
let g:ycm_enable_diagnostic_signs=1
let g:ycm_max_diagnostics_to_display=10000
let g:ycm_min_num_identifier_candidate_chars=0
let g:ycm_min_num_of_chars_for_completion=99
let g:ycm_open_loclist_on_ycm_diags=1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_show_diagnostics_ui=1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_error_symbol = "✗"
let g:ycm_warning_symbol =  "∙∙"
let g:ycm_filetype_blacklist={
            \ 'tagbar' : 1,
            \ 'qf' : 1,
            \ 'notes' : 1,
            \ 'markdown' : 1,
            \ 'md' : 1,
            \ 'unite' : 1,
            \ 'text' : 1,
            \ 'vimwiki' : 1,
            \ 'pandoc' : 1,
            \ 'infolog' : 1,
            \ 'mail' : 1
            \}
if !exists("g:ycm_semantic_triggers")
   let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']


" -------------------------------------
"  vim-airline
" -------------------------------------
" function! airline#extensions#tabline#formatters#default#format(bufnr, buffers)
"     let bufname = fnamemodify(bufname(a:bufnr), ':t')
"     let tokens = split(bufname, '\ze\u\|[-_]\zs')
"     call map(tokens, {i,v -> matchstr(v, '\a')})
"     let ext = fnamemodify(bufname, ':e')
"     let shortened = join(tokens, '').(!empty(ext) ? '.'.ext[0] : '')
"     " return shortened
"     return len(shortened) >= 5 ? shortened : bufname
" endfunction
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_powerline_fonts = 1
let g:airline_detect_modified=1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#fnametruncate = 8
let g:airline#extensions#tabline#formatter = 'default'
" let g:airline#extensions#tabline#buffers_label = '¯\_(ツ)_/¯'
let g:airline#extensions#tabline#buffers_label = '♪~ ᕕ(ᐛ)ᕗ'
let g:airline#extensions#branch#enabled = 1
" let g:airline#extensions#neomake#enabled = 1
let g:airline_theme='dark'
let g:airline_extensions = ['tabline', 'branch']
" let g:airline_extensions = ['tabline', 'branch', 'neomake']

" -------------------------------------
"  neomake
" -------------------------------------
" let g:neomake_javascript_enabled_makers = ['eslint']
" call neomake#configure#automake({
"   \ 'TextChanged': {},
"   \ 'InsertLeave': {},
"   \ 'BufWritePost': {'delay': 0},
"   \ 'BufWinEnter': {},
"   \ }, 500)


" -------------------------------------
"  neat-fold
" -------------------------------------
function! NeatFoldText() "{{{2
  let leading_spaces = len(getline(v:foldstart)) - len(substitute(getline(v:foldstart), '^\s*\(.\{-}\)\s*$', '\1', ''))
  let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
  let lines_count = v:foldend - v:foldstart + 1
  let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
  let foldchar = matchstr(&fillchars, 'fold:\zs.')
  let foldtextstart = strpart('+' . repeat(foldchar, leading_spaces-2) . line, 0, (winwidth(0)*2)/3)
  let foldtextend = lines_count_text . repeat(foldchar, 8)
  let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
  return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction
set foldtext=NeatFoldText()
" }}}2

" -------------------------------------
"  gf-node-friendly
" -------------------------------------
augroup suffixes
    autocmd!
    let associations = [["javascript", ".js,.jsx,.es6,.json,.scss"], ["python", ".py,.pyw"] ]

    for ft in associations
        execute "autocmd FileType " . ft[0] . " setlocal suffixesadd=" . ft[1]
    endfor
 augroup END

" -------------------------------------
"  toggle syntax-coloring
" -------------------------------------
nnoremap <silent> <Leader>s
             \ : if exists("syntax_on") <BAR>
             \    syntax off <BAR>
             \ else <BAR>  
             \    syntax enable <BAR>
             \ endif<CR>   

hi Normal ctermbg=NONE guibg=NONE
" -------------------------------------
"  mouse support inside tmux
" -------------------------------------
set mouse+=a
" if &term =~ '^screen'
"     " tmux knows the extended mouse mode
"     set ttymouse=xterm2
" endif
