" Install Vim Plug if not installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
   " Plug 'othree/yajs.vim'
   Plug 'pangloss/vim-javascript'
   Plug 'mxw/vim-jsx'

   " Plug 'leafgarland/typescript-vim'
   Plug 'HerringtonDarkholme/yats.vim'
   " Plug 'fleischie/vim-styled-components'
   Plug 'hail2u/vim-css3-syntax'

   " Plug 'othree/es.next.syntax.vim'
   " Plug 'mxw/vim-jsx'
   " Plug 'fleischie/vim-styled-components'

   Plug 'othree/javascript-libraries-syntax.vim'
   Plug 'keith/swift.vim'
   Plug 'vim-perl/vim-perl', { 'for': 'perl', 'do': 'make clean carp dancer highlight-all-pragmas moose test-more try-tiny' }

   Plug 'Valloric/YouCompleteMe'

   Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
   Plug 'junegunn/fzf.vim'

   Plug 'vim-airline/vim-airline'
   Plug 'vim-airline/vim-airline-themes'

   Plug 'crusoexia/vim-monokai'
   " Plug 'dracula/vim'
   Plug 'aunsira/macvim-light'
   Plug 'float168/vim-colors-cherryblossom'

   Plug 'tpope/vim-commentary'
   Plug 'tpope/vim-surround'
   Plug 'tpope/vim-fugitive'
   Plug 'tpope/vim-repeat'
   Plug 'tpope/vim-unimpaired'
   Plug 'nathanaelkane/vim-indent-guides'
   " Plug 'justinmk/vim-sneak'
   " Plug 'jiangmiao/auto-pairs'

   " Plug 'vim-syntastic/syntastic', { 'do': 'npm install -g tslint' }
   Plug 'neomake/neomake'

   Plug 'mattn/webapi-vim', { 'on': 'Gist' }
   Plug 'mattn/gist-vim', { 'on': 'Gist' }
   Plug 'jalvesaq/Nvim-R', { 'for': 'r' }

   Plug 'vim-perl/vim-perl', { 'for': 'perl', 'do': 'make clean carp dancer highlight-all-pragmas moose test-more try-tiny' }
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
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
syntax enable
set background=dark
filetype plugin on
let g:solarized_termcolors=256
let g:netrw_banner=0
au BufNewFile,BufRead *.es6 set filetype=javascript
au BufNewFile,BufRead *.vash set filetype=html
au BufNewFile,BufRead *.tt set filetype=html
" au BufNewFile,BufRead *.js set filetype=typescript
au BufNewFile,BufRead *.css,*.scss,*.less setlocal foldmethod=marker foldmarker={,}
set hidden
" set diffopt+=vertical
" -------------------------------------
"  Indentation
" -------------------------------------
set shiftwidth=4
set tabstop=4
set expandtab

" -------------------------------------
"  crusoexia/vim-monokai
" -------------------------------------
syntax on
colorscheme monokai
set t_Co=256

" -------------------------------------
"  Mappings
" -------------------------------------
nnoremap W :w<cr>
nnoremap Q :bd<cr>
nnoremap Z <c-z>
nnoremap L :bnext<cr>
nnoremap H :bprev<cr>
nnoremap K :YcmCompleter GetType<cr>
nnoremap gD :YcmCompleter GoToDefinition<cr>
nnoremap <C-n> :noh<cr>
"  vim-fugitive
cnoremap J <down>
cnoremap K <up>
cnoremap jjj J
cnoremap kkk K
cnoremap Noh noh
map <space> <leader>
nmap <leader>w <C-W>
nnoremap R :! ./%<cr>
nnoremap <leader>r R
" nmap ? yaw:Rhelp <c-r>"<cr>

" -------------------------------------
"  FZF
" -------------------------------------
nnoremap <c-p> :GFiles<cr>
nnoremap E :Files<cr>

" -------------------------------------
"  javascript-libraries-syntax  
" -------------------------------------
let g:used_javascript_libs = 'underscore,jquery,requirejs'
let g:typescript_indent_disable = 1

" -------------------------------------
"  vim-jsx
" -------------------------------------
let g:jsx_ext_required = 1

" -------------------------------------
"  YouCompleteMe
" -------------------------------------
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_always_populate_location_list = 1
let g:ycm_global_ycm_extra_conf='~/.config/nvim/.ycm_extra_conf.py'
let g:ycm_extra_conf_globlist=['~/.config/nvim/*']
let g:ycm_auto_trigger=1
let g:ycm_enable_diagnostic_highlighting=1
let g:ycm_enable_diagnostic_signs=1
let g:ycm_max_diagnostics_to_display=10000
let g:ycm_min_num_identifier_candidate_chars=0
let g:ycm_min_num_of_chars_for_completion=2
let g:ycm_open_loclist_on_ycm_diags=1
let g:ycm_show_diagnostics_ui=1
let g:ycm_collect_identifiers_from_tags_files = 1
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
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffers_label = '¯\_(ツ)_/¯'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#neomake#enabled = 1
let g:airline_theme='dark_minimal'
let g:airline_extensions = ['tabline', 'branch', 'neomake']

" -------------------------------------
"  neomake
" -------------------------------------
let g:neomake_javascript_enabled_makers = ['eslint']
call neomake#configure#automake({
  \ 'TextChanged': {},
  \ 'InsertLeave': {},
  \ 'BufWritePost': {'delay': 0},
  \ 'BufWinEnter': {},
  \ }, 500)

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
"  vim-indent-guide
" -------------------------------------
let g:indent_guides_enable_on_vim_startup = 0
hi IndentGuidesOdd ctermbg=236
hi IndentGuidesEven ctermbg=235

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

:hi Search cterm=NONE ctermfg=yellow ctermbg=darkgray

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
"  hail2u/vim-css3-syntax
" -------------------------------------
augroup VimCSS3Syntax
  autocmd!

  autocmd FileType css setlocal iskeyword+=-
augroup END

