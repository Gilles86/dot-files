" Install Vim Plug if not installed
if !has('nvim') && empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
if has('nvim') && empty(glob('~/.nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" vim-plug -------------------------------------------------------
call plug#begin(has('nvim') ? '~/.nvim/plugged' : '~/.vim/plugged')
   Plug 'vim-airline/vim-airline'

   Plug 'aminroosta/perldoc-vim'
   Plug 'scrooloose/nerdtree'
   Plug 'haya14busa/incsearch.vim'

   Plug 'neoclide/coc.nvim', {'branch': 'release'}

   Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
   Plug 'junegunn/fzf.vim'
   Plug 'ianding1/leetcode.vim'

   Plug 'tpope/vim-commentary'
   Plug 'tpope/vim-surround'
   Plug 'tpope/vim-fugitive'
   Plug 'tpope/vim-repeat'
   Plug 'tpope/vim-unimpaired'
   Plug 'tpope/vim-vinegar'

   Plug 'kassio/neoterm'
call plug#end()

filetype plugin on

let g:leetcode_browser = "firefox"
let g:leetcode_solution_filetype = "rust"

"  NERDTree ---------------------------
let g:NERDTreeDirArrowExpandable = "\u00a0"
let g:NERDTreeDirArrowCollapsible = "\u00a0"
let g:nerdtree_sync_cursorline = 1

"  Configurations ---------------------
set scrolloff=7
set foldlevel=99
set foldmethod=syntax
set numberwidth=2
set scl=no

set wrap
set linebreak
set breakindent
set showbreak=\ ~
set completeopt-=preview

set shiftwidth=4
set tabstop=4
set expandtab
set shiftround

set hidden
set hlsearch
set ignorecase
set smartcase
set path+=**
set wildmenu
set matchpairs+=<:>
set mouse+=a
set tags=./tags;/
set bs=2

" neoterm -----------------------------
" 3<leader>tl will clear neoterm-3.
nnoremap <leader>tc :<c-u>exec v:count.'Tclear'<cr>

" coc ---------------------------------
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>
set updatetime=300
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
nnoremap <silent> K :call <SID>show_documentation()<CR>
inoremap <silent><expr> <c-space> coc#refresh()
nnoremap <silent> Y  :<C-u>CocList -A --normal yank<cr>
nmap <leader>qf  <Plug>(coc-fix-current)
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"  Mappings ---------------------------
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap gj j
nnoremap gk k
vnoremap gj j
vnoremap gk k

nmap w <C-W>
map <space> <leader>
nnoremap W :w<cr>
nnoremap Q :bw<cr>
nnoremap Z <c-z>
nnoremap L :bnext<cr>
nnoremap H :bprev<cr>
" autocmd VimEnter *.* silent set laststatus=2
autocmd FileType perl setlocal complete-=i

nnoremap [* :Ggrep <cword> --<CR><CR>:copen<CR>
nnoremap ]* *``:Ggrep <cword> --<CR><CR>
nnoremap <C-n> :BTags<cr>

cnoremap J <down>
cnoremap K <up>
cnoremap jjj J
cnoremap kkk K
cnoremap Noh noh

"  colorscheme ------------------------
syntax on
set t_Co=256
set background=light
colorscheme desert
let g:solarized_termcolors=256
let g:netrw_banner=0
runtime! ftplugin/man.vim
call matchadd('ColorColumn', '\%81v', 100)

hi Normal ctermbg=NONE guibg=NONE

"  incsearch --------------------------
let g:incsearch#auto_nohlsearch = 1
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

"  vim-airline ------------------------
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_powerline_fonts = 1
let g:airline_detect_modified=1
let g:airline_statusline_ontop=1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='dark'
let g:airline_extensions = ['tabline']

"  highight-word ----------------------
function! HighlightWord()
    hi HighlightWord ctermbg=8
    let line=line('.')
    let cword = expand("<cword>")
    call matchadd('HighlightWord', cword, 50)
endfunction
nnoremap ) :call HighlightWord()<cr>
nnoremap ( :nohl<cr>:call clearmatches()<cr>

" syn-stack ---------------------------
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" FZF --------------------------------
" nnoremap <c-p> :GFiles<cr>
nnoremap E :Files<cr>
nnoremap T :Tags<cr>
nnoremap B :Buffers<cr>
nnoremap <leader>e :NERDTreeFind<cr>
nnoremap ? :Ag <c-r><c-w><cr>
imap <C-_> <plug>(fzf-complete-line)
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

"  neat-fold --------------------------
function! NeatFoldText()
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

" hilighting --------------------------
autocmd FileType json syntax match Comment +\/\/.\+$+
hi Search cterm=NONE ctermfg=NONE ctermbg=252
hi Visual cterm=NONE ctermbg=250 ctermfg=238
hi ColorColumn ctermbg=255
hi Error ctermbg=255 ctermfg=0
hi CocErrorHighlight ctermfg=196 cterm=underline
hi CocWarningHighlight ctermfg=130 cterm=underline

" highlighting pop-up -----------------
hi Pmenu ctermbg=15
hi PmenuSel ctermbg=250 
hi PmenuSbar ctermbg=248 

" matchparen --------------------------
function! g:FckThatMatchParen ()
    if exists(":NoMatchParen")
        :NoMatchParen
    endif
endfunction

" binary qa ----------------------------
iabbrev udd use Data::Dumper::Concise;<cr>warn Dumper

augroup plugin_initialize
    autocmd!
    autocmd VimEnter * call FckThatMatchParen()
augroup END

