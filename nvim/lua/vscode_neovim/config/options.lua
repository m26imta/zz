-- vscode-neovim  -  VSCode Neovim Integration
-- https://github.com/vscode-neovim/vscode-neovim

vim.cmd([[
""
let mapleader = " "
let maplocalleader = "\\"
nnoremap ; :
map <C-f> <Nop>
map <C-b> <Nop>
map <S-f> <Nop>

"" Options
set timeoutlen=400
let g:clipboard = g:vscode_clipboard
set iskeyword+=- backspace=indent,eol,start
set nolist listchars=tab:→\ ,nbsp:␣,trail:•,space:⋅,extends:▶,precedes:◀,eol:↴


"" Keymaps
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

"" Ctrl+A to select all
nnoremap <C-a> maggVG

"" Do not yank on x & p
nnoremap x "_x
vnoremap p "_dP

"" Quick paste using + register
inoremap <C-r><C-r> <C-\><C-o>"+P
cnoremap <C-r><C-r> <C-r>+

"" Search & Replace
vnoremap <leader>fi y<ESC>/<C-r>"<CR>
vnoremap <leader>re "hy:%s/<C-r>h//gc

" inoremap <C-j> <Down>
" map! <C-k> <cmd>lua require("vscode-neovim").action("cursorUp")<CR>
map! <C-h> <cmd>lua require("vscode-neovim").action("cursorLeft")<CR>
map! <C-l> <cmd>lua require("vscode-neovim").action("cursorRight")<CR>

nnoremap <C-x> <cmd>lua require("vscode-neovim").call('editor.action.formatDocument')<CR>
nnoremap ? <Cmd>lua require('vscode-neovim').action('workbench.action.findInFiles', { args = { query = vim.fn.expand('<cword>') } })<CR>
nnoremap <leader>1 <cmd>lua require("vscode-neovim").action("workbench.action.toggleSidebarVisibility")<CR>
nnoremap <leader>e <cmd>lua require("vscode-neovim").action("workbench.files.action.focusFilesExplorer")<CR>
nnoremap <leader>fe <cmd>lua require("vscode-neovim").action("workbench.files.action.focusFilesExplorer")<CR>

nnoremap <S-x> <cmd>lua require("vscode-neovim").call("workbench.action.closeActiveEditor")<CR>

]])
