" Install Vim Plug if not installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
   Plug 'sheerun/vim-polyglot'
   Plug 'rhysd/vim-clang-format'
   "Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

   Plug 'hail2u/vim-css3-syntax'
   " Plug 'Valloric/YouCompleteMe'
   Plug 'roxma/nvim-completion-manager'
   Plug 'gaalcaras/ncm-R'

   Plug 'w0rp/ale'

   Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
   Plug 'junegunn/fzf.vim'

   Plug 'vim-airline/vim-airline'
   " Plug 'vim-airline/vim-airline-themes'

   Plug 'crusoexia/vim-monokai'
   " Plug 'dracula/vim'
   Plug 'aunsira/macvim-light'
   Plug 'float168/vim-colors-cherryblossom'

   Plug 'tpope/vim-commentary'
   Plug 'tpope/vim-surround'
   Plug 'tpope/vim-fugitive'
   Plug 'tpope/vim-repeat'
   Plug 'tpope/vim-unimpaired'
   " Plug 'justinmk/vim-sneak'
   " Plug 'jiangmiao/auto-pairs'
   Plug 'jalvesaq/Nvim-R'
   Plug 'rizzatti/dash.vim'

   " Plug 'vim-syntastic/syntastic', { 'do': 'npm install -g tslint' }
   " Plug 'neomake/neomake'
call plug#end()

" -------------------------------------
"  Configurations
" -------------------------------------
set scrolloff=7
set foldlevel=99
" set cursorline
" set lazyredraw
set foldmethod=syntax
"set number
"set relativenumber
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
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
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

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'r': ['lintr'],
\}

" -------------------------------------
"  crusoexia/vim-monokai
" -------------------------------------
syntax on
colorscheme monokai
set t_Co=256
set path+=**
set wildmenu
highlight Normal ctermbg=232
highlight Search cterm=NONE ctermfg=214 ctermbg=236
highlight YcmErrorLine ctermbg=233 ctermfg=204
highlight YcmErrorSection ctermbg=236 ctermfg=196
highlight ColorColumn ctermbg=238 
highlight Error ctermbg=233 ctermfg=204
call matchadd('ColorColumn', '\%81v', 100)

" -------------------------------------
"  Mappings
" -------------------------------------
nnoremap W :w<cr>
nnoremap Q :bd<cr>
nnoremap Z <c-z>
nnoremap L :bnext<cr>
nnoremap H :bprev<cr>
nnoremap K :YcmCompleter GetType<cr>
autocmd BufNewFile,BufRead FileType cpp map <buffer> gD :YcmCompleter GoToDefinition<cr>
autocmd BufNewFile,BufRead FileType cpp map <buffer> gd :YcmCompleter GoToDeclaration<cr>
autocmd BufNewFile,BufRead FileType cpp map <buffer> gF :YcmCompleter GoToInclude<cr>
nnoremap [* :Ggrep <cword> --<CR><CR>:copen<CR>
nnoremap ]* *``:Ggrep <cword> --<CR><CR>
nnoremap <C-n> :noh<cr>
"  vim-fugitive
cnoremap J <down>
cnoremap K <up>
cnoremap jjj J
cnoremap kkk K
cnoremap Noh noh
nmap w <C-W>
nmap <space>d <Plug>DashSearch<cr>
nnoremap R :! ./%<cr>

" -------------------------------------
"  FZF
" -------------------------------------
nnoremap <c-p> :GFiles<cr>
nnoremap E :Files<cr>

" -------------------------------------
"  YouCompleteMe
" -------------------------------------
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_always_populate_location_list = 1
let g:ycm_global_ycm_extra_conf='~/.ycm_extra_conf.py'
let g:ycm_extra_conf_globlist=['~/.config/nvim/*']
let g:ycm_auto_trigger=1
let g:ycm_enable_diagnostic_highlighting=1
let g:ycm_enable_diagnostic_signs=1
let g:ycm_max_diagnostics_to_display=10000
let g:ycm_min_num_identifier_candidate_chars=0
let g:ycm_min_num_of_chars_for_completion=2
let g:ycm_open_loclist_on_ycm_diags=1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_show_diagnostics_ui=1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_error_symbol = '✗'
let g:ycm_warning_symbol =  '∙∙'
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
if !exists('g:ycm_semantic_triggers')
   let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']

" -------------------------------------
"  vim-airline
" -------------------------------------
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#buffers_label = '¯\_(ツ)_/¯'
let g:airline#extensions#tabline#buffers_label = '♪~ ᕕ(ᐛ)ᕗ'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#neomake#enabled = 0
" let g:airline_theme='dark_minimal'
let g:airline_extensions = ['tabline', 'branch']

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
"  syntastic
" -------------------------------------
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list = 0
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 0
" let g:syntastic_check_on_wq = 0
" " let g:syntastic_mode_map = { "mode": "active", "passive_filetypes": ["go", "javascript", "html", "css", "scss", "typescript"] }
" " let g:syntastic_swift_checkers = ['swiftpm'] 
" let g:syntastic_html_checkers = [''] 
" let g:syntastic_html_checkers = [''] 
" let g:syntastic_swift_checkers = ['swiftpm', 'swiftlint']
" let g:syntastic_javascript_eslint_exe='$(npm bin)/eslint'
" let g:syntastic_javascript_checkers=['eslint']
" let g:syntastic_typescript_checkers = ['eslint']
" let g:syntastic_error_symbol = "✗"
" let g:syntastic_style_error_symbol = "✗"
" let g:syntastic_warning_symbol = "∙∙"
" let g:syntastic_style_warning_symbol = "∙∙"
" " autofix with eslint
" let g:syntastic_javascript_eslint_args = ['--fix']
" function! SyntasticCheckHook(errors)
"   checktime
" endfunction

" -------------------------------------
"  neat-fold
" -------------------------------------
function! NeatFoldText() "{{{2
  let l:leading_spaces = len(getline(v:foldstart)) - len(substitute(getline(v:foldstart), '^\s*\(.\{-}\)\s*$', '\1', ''))
  let l:line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
  let l:lines_count = v:foldend - v:foldstart + 1
  let l:lines_count_text = '| ' . printf('%10s', l:lines_count . ' lines') . ' |'
  let l:foldchar = matchstr(&fillchars, 'fold:\zs.')
  let l:foldtextstart = strpart('+' . repeat(l:foldchar, l:leading_spaces-2) . l:line, 0, (winwidth(0)*2)/3)
  let l:foldtextend = l:lines_count_text . repeat(l:foldchar, 8)
  let l:foldtextlength = strlen(substitute(l:foldtextstart . l:foldtextend, '.', 'x', 'g')) + &foldcolumn
  return l:foldtextstart . repeat(l:foldchar, winwidth(0)-l:foldtextlength) . l:foldtextend
endfunction
set foldtext=NeatFoldText()
" }}}2

" -------------------------------------
"  gf-node-friendly
" -------------------------------------
augroup suffixes
    autocmd!
    let g:associations = [['javascript', '.js,.jsx,.es6,.json,.scss'], ['python', '.py,.pyw'] ]

    for g:ft in g:associations
        execute 'autocmd FileType ' . g:ft[0] . ' setlocal suffixesadd=' . g:ft[1]
    endfor
 augroup END

" -------------------------------------
"  vim-clang-format
" -------------------------------------
" let g:clang_format#command = '/usr/local/opt/llvm/bin/clang-format'
" let g:clang_format#style_options = {
"             \ "AllowShortIfStatementsOnASingleLine" : "true",
"             \ "AlwaysBreakTemplateDeclarations" : "true", 
"             \ "ColumnLimit" : 100 }

" -------------------------------------
"  toggle syntax-coloring
" -------------------------------------
nnoremap <silent> <Leader>s
             \ : if exists("syntax_on") <BAR>
             \    syntax off <BAR>
             \ else <BAR>  
             \    syntax enable <BAR>
             \ endif<CR>   
