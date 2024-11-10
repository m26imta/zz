""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" vimrc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = " "
let maplocalleader = "\\"

color industry
silent! color habamax

"" Options
set timeoutlen=300
set clipboard=unnamed,unnamedplus
set mouse=a number norelativenumber cursorline
set ts=2 sw=2 sts=2
set autoindent smartindent expandtab smarttab
set ignorecase smartcase incsearch hlsearch noshowmatch
set nobackup writebackup swapfile undofile confirm
set iskeyword+=- backspace=indent,eol,start
set wrap linebreak showbreak=↪ whichwrap+=<,>,[,],h,l
set scrolloff=4 sidescrolloff=8
set nolist listchars=tab:→\ ,nbsp:␣,trail:•,space:⋅,extends:▶,precedes:◀,eol:↴
" set shortmess+=c
" set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/.git/*

"" Keymaps
nnoremap ; :
inoremap jk <ESC>
"" fix error 2;2R in vim. <ESC> -> nohl only in neovim
if has('nvim')
  nnoremap <silent> <ESC> :nohl<CR>
endif
nnoremap <silent> <leader><ESC> :nohl<CR>
"" nnoremap <C-x> :q!<CR>
nnoremap <C-q> :q!<CR>
map <c-f> <Nop>
map <c-b> <Nop>
map <s-j> <Nop>

"" Toggle wrap, listchars & relativenumber
map <F5> :set relativenumber!<CR>
map <F7> :set wrap!<CR>:set wrap?<CR>
map <F8> :set list!<CR>:set list?<CR>

" Use CTRL-S for saving, also in Insert mode (<C-O> doesn't work well when
" using completions).
noremap  <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <Esc>:update<CR>gi

"" Buffer
" delete buffer
nnoremap <S-x> :bd!<CR>
" nnoremap <S-x> :exe 'if exists("Bd") \| Bd \| else \| bd \| endif'
function Do_del_buffer()
  if exists(":Bdelete")>0
    :Bdelete!
  else
    :bdel!
  endif
endfunction
nnoremap <silent> <S-x> :call Do_del_buffer()<CR>
nnoremap <silent> <S-x> :execute exists(":Bdelete")>0?"Bdelete!":"bdel!"<CR>
"
nnoremap <S-h> :bp<CR>
nnoremap <S-l> :bn<CR>
noremap <C-PageUp> :bp<CR>
noremap <C-PageDown> :bn<CR>
nnoremap ~ :b#<CR>
" nnoremap <M-`> :b#<CR>
" nnoremap <S-Tab> :b#<CR>
" nnoremap <leader>bb :ls<CR>:b<Space>
" nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

"" Move around text in InsertMode & CommandMode
noremap! <C-j> <Nop>
noremap! <C-k> <Nop>
cnoremap <C-j> <DOWN>
cnoremap <C-k> <UP>
noremap! <C-h> <LEFT>
noremap! <C-l> <RIGHT>

"" Better move through wrap line
noremap j g<DOWN>
noremap k g<UP>
" inoremap <C-j> <C-o>g<DOWN>
" inoremap <C-k> <C-o>g<UP>

"" Move around windows
nnoremap <C-h> <C-w><LEFT>
nnoremap <C-l> <C-w><RIGHT>
nnoremap <C-j> <C-w><DOWN>
nnoremap <C-k> <C-w><UP>
" CTRL-Tab is Next window
noremap <C-Tab> <C-W>w
inoremap <C-Tab> <C-O><C-w>w
cnoremap <C-Tab> <C-C><C-w>w
onoremap <C-Tab> <C-C><C-w>w

"" Indent
nnoremap < v<
nnoremap > v>
vnoremap < <gv
vnoremap > >gv
vnoremap <S-h> <gv
vnoremap <S-l> >gv

"" Move lines up & down
vnoremap <S-j> :m '>+1<cr>gv=gv
vnoremap <S-k> :m '<-2<cr>gv=gv

nnoremap <A-j> :m .+1<cr>==
nnoremap <A-k> :m .-2<cr>==
inoremap <A-j> <ESC>:m .+1<cr>==gi
inoremap <A-k> <ESC>:m .-2<cr>==gi
vnoremap <A-j> :m '>+1<cr>gv=gv
vnoremap <A-k> :m '<-2<cr>gv=gv

nnoremap <A-,> :m .+1<cr>==
nnoremap <A-.> :m .-2<cr>==
inoremap <A-,> <ESC>:m .+1<cr>==gi
inoremap <A-.> <ESC>:m .-2<cr>==gi 
vnoremap <A-,> :m '>+1<cr>gv=gv
vnoremap <A-.> :m '<-2<cr>gv=gv

nnoremap <A-h> v<
nnoremap <A-l> v>
inoremap <A-h> <ESC>v<gi
inoremap <A-l> <ESC>v>gi
vnoremap <A-h> <gv
vnoremap <A-l> >gv

"" Ctrl+A to select all
nnoremap <C-a> maggVG

"" Increment & Decrement number
nnoremap - <C-x>
nnoremap = <C-a>

"" Do not yank on x & p
nnoremap x "_x
vnoremap p "_dP

"" Quick paste using + register
inoremap <C-r><C-r> <C-\><C-o>"+P
cnoremap <C-r><C-r> <C-r>+

"" Search & Replace
nnoremap <C-f> <Nop>
vnoremap <C-f> y<ESC>/<C-r>"<CR>
vnoremap <C-r> <Nop>
vnoremap <C-r><C-e> "hy:%s/<C-r>h//gc<LEFT><LEFT><LEFT>

"" Status line
if &statusline==""
  set showmode
  set laststatus=2
  set statusline=\ %{&paste==1?'[PASTE\ MODE]\ \ ':''}\ %t\ %w\ \|\ CWD:\ %r%{getcwd()}%h\ \ \|\ %l:%c\ 
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Netrw
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" https://vonheikemen.github.io/devlog/tools/using-netrw-vim-builtin-file-explorer/
let g:netrw_keepdir = 0
let g:netrw_winsize = 30
nnoremap <leader>dd :cd %:p:h<CR>:Lexplore<CR>:pwd<CR>
nnoremap <leader>de :Lexplore<CR>
nnoremap <leader>1 :Lexplore<CR>

function! NetrwMapping()
  nmap <buffer> H u
  nmap <buffer> h -^
  nmap <buffer> l <CR>

  nmap <buffer> . gh
  nmap <buffer> P <C-w>z
  nmap <buffer> <C-l> <C-w>l

  nmap <buffer> L <CR>:Lexplore<CR>
  nmap <buffer> <Leader>dd :Lexplore<CR>
endfunction 

augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMapping()
augroup END


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" VIM
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !has("nvim")
  "" Change Your Vim Cursor from a Block to Line in Insert Mode
  let &t_SI = "\e[6 q"
  let &t_EI = "\e[2 q"

  "" write as sudo
  if has("unix")
    "cmap w!! w !sudo tee > /dev/null %
    command! W execute 'w !sudo tee % > /dev/null' <bar> edit!
  endif
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Neovide
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if exists("g:neovide")
  let cursor_vfx_mode = ["railgun", "torpedo", "pixiedust", "sonicboom", "ripple", "wireframe"]
  let g:neovide_cursor_vfx_mode = cursor_vfx_mode[5]
  set guifont=JetBrainsMono\ Nerd\ Font:h11
  let g:neovide_transparency = 0.95
  " let g:neovide_fullscreen = v:true  "" windowed fullscreen mode
  nnoremap <F11> :let g:neovide_fullscreen = !g:neovide_fullscreen<CR>
  let g:neovide_cursor_animation_length = 0.08 "" default = 0.06
  let g:neovide_cursor_trail_size = 0.8 "" default = 0.7
  " let g:neovide_cursor_antialiasing = v:false  "" Disabling may fix some cursor visual issues.
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Vim-Plug
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""  Use this for Windows installation
"" iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim | ni $HOME/vimfiles/autoload/plug.vim -Force
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" auto install vim-plug
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("unix") && !has("nvim")
  let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
  if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
endif


if !has("nvim")
call plug#begin()
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" List your plugins here

Plug 'tpope/vim-sensible'
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }

Plug 'nvim-tree/nvim-web-devicons'
" Plug 'akinsho/bufferline.nvim', { 'tag': '*' }

"" Delete buffers and close files in Vim without closing your windows or messing up your layout.
Plug 'https://github.com/moll/vim-bbye'

"" ayu theme
Plug 'Luxed/ayu-vim'    " or other package manager
"...

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" nerdtree config
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
let g:NERDTreeMapActivateNode = 'l'
let g:NERDTreeMapJumpParent = 'h'

"" bufferline config
"set termguicolors
"lua << EOF
"require"bufferline".setup{}
"EOF

"" ayu-theme
set termguicolors       " enable true colors support
""set background=light    " for light version of theme
set background=dark     " for either mirage or dark version.
" NOTE: `background` controls `g:ayucolor`, but `g:ayucolor` doesn't control `background`
""let g:ayucolor="mirage" " for mirage version of theme
let g:ayucolor="dark"   " for dark version of theme
" NOTE: g:ayucolor will default to 'dark' when not set.
silent! colorscheme ayu

endif
