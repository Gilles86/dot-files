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

" rusty-tags --------------------------------------------
function! RustInit(info)
if a:info.status == 'installed' || a:info.force
    !curl https://sh.rustup.rs -sSf | sh -s -- -y
    !~/.cargo/bin/rustup component list | grep -q rust-src || ~/.cargo/bin/rustup component add rust-src
    !~/.cargo/bin/cargo install --list | grep -q rusty-tags || ~/.cargo/bin/cargo install rusty-tags
    !mkdir -p ~/.rusty-tags && echo 'vi_tags = ".tags-rs"' > ~/.rusty-tags/config.toml

    if has('nvim')
        !~/.cargo/bin/cargo install --list | grep -q racer || ~/.cargo/bin/cargo install racer
    endif

    !grep -q 'RUST_SRC_PATH' ~/.bashrc ||
                \echo 'export RUST_SRC_PATH=
                \$(rustc --print sysroot)/lib/rustlib/src/rust/src/' >> ~/.bashrc
endif
endfunction

autocmd FileType rust map <buffer> K :echo taglist('<c-r><c-w>')[0]['cmd'][2:-3]<cr>
autocmd BufRead *.rs :setlocal tags=./.tags-rs;/,$RUST_SRC_PATH/.tags-rs
autocmd BufWritePost *.rs :silent! exec 
            \"!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!
" -------------------------------------------------------

call plug#begin(has('nvim') ? '~/.nvim/plugged' : '~/.vim/plugged')
   Plug 'sheerun/vim-polyglot'

if has("mac") && 0
    Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --rust-completer' }
    Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
    Plug 'prettier/vim-prettier', {'do': 'npm install', 'branch': 'release/1.x' }
endif

if has('nvim')
   Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
   Plug 'sebastianmarkow/deoplete-rust'

endif

   Plug 'ervandew/supertab'
   Plug 'SirVer/ultisnips'
   Plug 'honza/vim-snippets'

   Plug 'dan-t/rusty-tags', { 'do': function('RustInit') }
   Plug 'w0rp/ale'

   Plug 'haya14busa/incsearch.vim'
   Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
   Plug 'junegunn/fzf.vim'

   Plug 'AndrewRadev/splitjoin.vim'
   Plug 'vim-airline/vim-airline'
   Plug 'amix/open_file_under_cursor.vim'
   Plug 'majutsushi/tagbar', { 'on':  'Tagbar' }
   Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeFind' }
   Plug 'unkiwii/vim-nerdtree-sync', { 'on': 'NERDTreeFind' }

   Plug 'tpope/vim-commentary'
   Plug 'tpope/vim-surround'
   Plug 'tpope/vim-fugitive'
   Plug 'tpope/vim-repeat'
   Plug 'tpope/vim-unimpaired'

   Plug 'aminroosta/perldoc-vim', { 'for': 'perl' }
call plug#end()

filetype plugin on

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
nnoremap ? :Ag <c-r><c-w><cr>
autocmd VimEnter *.* silent set laststatus=2
autocmd FileType perl setlocal complete-=i

nnoremap [* :Ggrep <cword> --<CR><CR>:copen<CR>
nnoremap ]* *``:Ggrep <cword> --<CR><CR>
nnoremap <C-n> :BTags<cr>

cnoremap J <down>
cnoremap K <up>
cnoremap jjj J
cnoremap kkk K
cnoremap Noh noh

inoremap {<cr> {}<esc>i<cr><esc>ko

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
imap <C-_> <plug>(fzf-complete-line)
tnoremap <c-n> <c-\><c-n>

" vim-snippets -------------------------
 let g:UltiSnipsExpandTrigger="<S-tab>"
 let g:UltiSnipsJumpForwardTrigger="<c-m>"
 let g:UltiSnipsJumpBackwardTrigger="<c-M>"

"  perldoc ----------------------------
let g:perldoc_split_modifier = '76v'

"  deoplete ---------------------------
let g:deoplete#enable_at_startup = 1

"  supertab ---------------------------
let g:SuperTabDefaultCompletionType = "<c-n>"

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
let g:airline#extensions#branch#enabled = 1
let g:airline_theme='dark'
let g:airline_extensions = ['tabline', 'branch']

"  NERDTree ---------------------------
let g:NERDTreeDirArrowExpandable = "\u00a0"
let g:NERDTreeDirArrowCollapsible = "\u00a0"
let g:nerdtree_sync_cursorline = 1
let g:netrw_list_hide= '.*\.swp$,\~$,\.orig$'

if has("mac") && 0
    "  prettier ---------------------------
    let g:prettier#autoformat = 0
    autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync

    autocmd FileType rust map <buffer> K :echo taglist("<c-r><c-w>")[0]['cmd']<cr>

    "  YouCompleteMe ----------------------
    autocmd FileType c,cpp map <buffer> K :YcmCompleter GetType<cr>
    autocmd FileType c,cpp,rust map <buffer> gD :YcmCompleter GoToDefinition<cr>
    autocmd FileType c,cpp,rust map <buffer> gd :YcmCompleter GoToDeclaration<cr>
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
endif

"  Tagbar -----------------------------
let g:tagbar_width = 24
let g:tagbar_indent = 0
let g:tagbar_show_linenumbers = 0

"  highight-word ----------------------
function! HighlightWord()
    let line=line('.')
    let cword = expand("<cword>")
    call matchadd('HighlightWord', cword, 50)
    hi HighlightWord ctermbg=8
endfunction
nnoremap ) :call HighlightWord()<cr>*``
nnoremap ( :call clearmatches()<cr>:nohl<cr>

" deoplete ----------------------------
if has('nvim')
    let g:deoplete#sources#rust#racer_binary=systemlist('which racer')[0]
    let g:deoplete#sources#rust#rust_source_path=$RUST_SRC_PATH

    call deoplete#custom#option({ 'min_pattern_length': 5 })
endif

" syn-stack ---------------------------
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

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

if has('nvim')
    colorscheme zellner
else
    colorscheme default
endif

" hilighting --------------------------
hi Search cterm=NONE ctermfg=NONE ctermbg=252
hi Visual cterm=NONE ctermbg=250 ctermfg=238
hi ColorColumn ctermbg=255
hi Error ctermbg=9 ctermfg=0

" highlighting pop-up -----------------
hi ALEErrorLine ctermbg=255
hi Pmenu ctermbg=15
hi PmenuSel ctermbg=250 
hi PmenuSbar ctermbg=248

" highlighting rust -------------------
hi rustFuncCall ctermfg=232
hi rustModPath ctermfg=19
hi rustString ctermfg=18
hi link rustModPathSep rustModPath
hi link rustMacro rustFuncCall
hi link rustKeyword rustStorage
hi link rustConditional rustStorage
hi link rustDecNumber rustString
