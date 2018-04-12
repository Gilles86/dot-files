" Install Vim Plug if not installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')

   Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
   Plug 'junegunn/fzf.vim'

   Plug 'vim-airline/vim-airline'
   Plug 'crusoexia/vim-monokai'


   Plug 'scrooloose/nerdtree'

   Plug 'tpope/vim-fugitive'
   Plug 'tpope/vim-commentary'
   Plug 'tpope/vim-surround'
   Plug 'tpope/vim-unimpaired'
   Plug 'tpope/vim-repeat'

   Plug 'neomake/neomake'

   Plug 'rhysd/vim-clang-format'
   Plug 'roxma/nvim-completion-manager'
   Plug 'roxma/ncm-clang'
   Plug 'Rip-Rip/clang_complete'

   Plug 'sheerun/vim-polyglot'
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

" -------------------------------------
"  Mappings
" -------------------------------------
nmap w <C-W>
nnoremap W :w<cr>
nnoremap Q :bw<cr>
nnoremap Z <c-z>
nnoremap L :bnext<cr>
nnoremap H :bprev<cr>
nnoremap <C-n> :noh<cr>
nnoremap <leader><space> :NERDTreeFind %<CR>
cnoremap J <down>
cnoremap K <up>
cnoremap jjj J
cnoremap kkk K
cnoremap Noh noh
map <space> <leader>
nnoremap <C-w>o :tab sp<cr>
" YCM
nnoremap K :YcmCompleter GetType<cr>
autocmd FileType cpp map <buffer> gD :YcmCompleter GoToDefinition<cr>
autocmd FileType cpp map <buffer> gd :YcmCompleter GoToDeclaration<cr>
autocmd FileType cpp map <buffer> gF :YcmCompleter GoToInclude<cr>
" FZF
nnoremap <c-p> :GFiles<cr>
nnoremap E :Files<cr>

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
call matchadd('ColorColumn', '\%121v', 100)

" -------------------------------------
"  nvim-completion-manager
" -------------------------------------
set shortmess+=c
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
let g:clang_library_path = '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/libclang.dylib'
let g:cm_matcher = {'module': 'cm_matchers.prefix_matcher', 'case': 'smartcase'}
let g:cm_refresh_length = [ [1,2], [7,2] ]

" let g:clang_make_default_keymappings = 0
" let g:clang_auto_user_options = ''
" function! WrapClangGoTo()
"     let cwd = getcwd()
"     let info = ncm_clang#compilation_info()
"     exec 'cd ' . info['directory']
"     try
"         let b:clang_user_options = join(info['args'], ' ')
"         call g:ClangGotoDeclaration()
"     catch
"     endtry
"     exec 'cd ' . cwd
" endfunc
" autocmd FileType c,cpp nnoremap <buffer> gd :call WrapClangGoTo()<CR>

" -------------------------------------
"  vim-airline
" -------------------------------------
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
let g:airline#extensions#neomake#enabled = 1
let g:airline_theme='dark'
let g:airline_extensions = ['tabline', 'branch', 'neomake']
" function! airline#extensions#tabline#formatters#default#format(bufnr, buffers)
"     let bufname = fnamemodify(bufname(a:bufnr), ':t')
"     let tokens = split(bufname, '\ze\u\|[-_]\zs')
"     call map(tokens, {i,v -> matchstr(v, '\a')})
"     let ext = fnamemodify(bufname, ':e')
"     let shortened = join(tokens, '').(!empty(ext) ? '.'.ext[0] : '')
"     " return shortened
"     return len(shortened) >= 5 ? shortened : bufname
" endfunction

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

" -------------------------------------
"  mouse support inside tmux
" -------------------------------------
set mouse+=a
if &term =~ '^screen'
    set ttymouse=xterm2
endif
