" Install Vim Plug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
   Plug 'sheerun/vim-polyglot'

   Plug 'ervandew/supertab'
   Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' }
   Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

   Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
   Plug 'junegunn/fzf.vim'

   Plug 'vim-airline/vim-airline'
   Plug 'amix/open_file_under_cursor.vim'
   Plug 'majutsushi/tagbar', { 'on':  'Tagbar' }
   Plug 'scrooloose/nerdtree'
   Plug 'unkiwii/vim-nerdtree-sync'
   Plug 'airblade/vim-gitgutter'

   Plug 'tpope/vim-commentary'
   Plug 'tpope/vim-surround'
   Plug 'tpope/vim-fugitive'
   Plug 'tpope/vim-repeat'
   Plug 'tpope/vim-unimpaired'

   Plug 'aminroosta/perldoc-vim', { 'for': 'perl' }
   Plug 'vim-scripts/perl-support.vim', { 'for': 'perl' }

call plug#end()

filetype plugin on

"  Configurations ---------------------
set scrolloff=7
set foldlevel=99
set foldmethod=syntax
set numberwidth=2

set wrap
set linebreak
set breakindent
set showbreak=\ \

set shiftwidth=4
set tabstop=4
set expandtab
set shiftround

set hidden
set hlsearch
set ignorecase
set smartcase
set encoding=utf-8
set path+=**
set wildmenu
set matchpairs+=<:>
set mouse+=a
set fileencoding=utf8
set encoding=utf8
set tags=./tags;/

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
autocmd BufWinLeave *.* mkview!
autocmd BufWinEnter *.* silent loadview
autocmd BufWinEnter *.* silent set laststatus=0
autocmd VimEnter *.* silent set laststatus=0

nnoremap [* :Ggrep <cword> --<CR><CR>:copen<CR>
nnoremap ]* *``:Ggrep <cword> --<CR><CR>
nnoremap <C-n> :BTags<cr>
nnoremap <esc> :noh<cr>
cnoremap J <down>
cnoremap K <up>
cnoremap jjj J
cnoremap kkk K
cnoremap Noh noh

"  colorscheme ------------------------
syntax on
set t_Co=256
set background=dark
let g:solarized_termcolors=256
let g:netrw_banner=0
runtime! ftplugin/man.vim
call matchadd('ColorColumn', '\%81v', 100)

hi Normal ctermbg=NONE guibg=NONE

"  FZF --------------------------------
nnoremap <c-p> :GFiles<cr>
nnoremap E :Files<cr>
nnoremap T :Tags<cr>
nnoremap B :Buffers<cr>
nnoremap e :NERDTreeFind<cr>
tnoremap <c-n> <c-\><c-n>

"  perldoc ----------------------------
let g:perldoc_split_modifier = '76v'

"  supertab ---------------------------
let g:SuperTabDefaultCompletionType = "<c-n>"

"  vim-airline ------------------------
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_powerline_fonts = 1
let g:airline_detect_modified=1
let g:airline_statusline_ontop=1
" let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#formatter = 'default'
" let g:airline#extensions#tabline#buffers_label = 'ಠ‿↼'
let g:airline#extensions#branch#enabled = 1
let g:airline_theme='dark'
let g:airline_extensions = ['tabline', 'branch']

"  NERDTree ---------------------------
let g:NERDTreeDirArrowExpandable = "\u00a0"
let g:NERDTreeDirArrowCollapsible = "\u00a0"
let g:nerdtree_sync_cursorline = 1
let g:netrw_list_hide= '.*\.swp$,\~$,\.orig$'

"  YouCompleteMe ----------------------
autocmd FileType c,cpp map <buffer> K :YcmCompleter GetType<cr>
autocmd FileType c,cpp map <buffer> gD :YcmCompleter GoToDefinition<cr>
autocmd FileType c,cpp map <buffer> gd :YcmCompleter GoToDeclaration<cr>
autocmd FileType c,cpp map <buffer> gF :YcmCompleter GoToInclude<cr>
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
let g:ycm_filetype_blacklist={ 'tagbar':1, 'qf':1, 'notes':1, 'markdown':1, 'md':1,
            \'unite':1, 'text':1, 'vimwiki':1, 'pandoc':1, 'infolog':1, 'mail':1 }

"  Tagbar -----------------------------
let g:tagbar_width = 24
let g:tagbar_indent = 0
let g:tagbar_show_linenumbers = 0

function! HighlightBlock()
    let line=line('.')
    let cword = expand("<cword>")
    let pattern = '\%'.line.'l'
    call matchadd('ColorColumn', pattern, 50)
    hi ColorColumn ctermbg=8
endfunction
nnoremap ) :call HighlightBlock()<cr>j
nnoremap ( :call clearmatches()<cr>

"  neat-fold --------------------------
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

colorscheme desert
hi Search cterm=NONE ctermfg=NONE ctermbg=252
hi Visual cterm=NONE ctermbg=250
hi ColorColumn ctermbg=255
hi Error ctermbg=9 ctermfg=0
set fileencoding=utf8
set encoding=utf8
set clipboard=unnamed
