" General Settings
set nocompatible            " Disable Vi compatibility
set encoding=utf-8          " Use UTF-8 encoding
set number                  " Show line numbers
set relativenumber          " Show relative line numbers
set mouse=a                 " Enable mouse support
set clipboard=unnamedplus   " Use system clipboard
set termguicolors           " Enable true colors

" Searching
set ignorecase              " Ignore case when searching
set smartcase               " Case-sensitive if query contains uppercase
set hlsearch                " Highlight search results
set incsearch               " Incremental search

" Indentation
set tabstop=2               " Number of spaces for a tab
set shiftwidth=2            " Number of spaces for indentation
set expandtab               " Convert tabs to spaces
set autoindent              " Copy indentation from previous line
set smartindent             " Smart auto-indentation

" Scrolling
set scrolloff=8             " Keep 8 lines visible above/below cursor

" Status Line (Simple Lualine-like)
set laststatus=2            " Always show status line
set showcmd                 " Display incomplete commands

" Split Window Navigation (Like Neovim's <C-h/j/k/l>)
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Resize Splits with Arrow Keys
nnoremap <C-Up> :resize +2<CR>
nnoremap <C-Down> :resize -2<CR>
nnoremap <C-Left> :vertical resize -2<CR>
nnoremap <C-Right> :vertical resize +2<CR>

" Quick Save & Quit
nnoremap <C-s> :w<CR>
nnoremap <C-q> :q<CR>
nnoremap <leader>x :bd<CR>   " Close current buffer

" Disable Arrow Keys for Navigation (Force to use hjkl)
map <Up> <Nop>
map <Down> <Nop>
map <Left> <Nop>
map <Right> <Nop>

" Code Navigation (Similar to Telescope, but basic)
nnoremap <leader>ff :find  " File Search
nnoremap <leader>fg :grep  " Text Search in Files

" Tabs (Like Bufferline)
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" Select All Text (VSCode-style)
nnoremap <C-a> ggVG

" Toggle Search Highlight
nnoremap <leader>/ :nohlsearch<CR>

" Cursorline (Highlight Current Line)
set cursorline

" Theme (Looks Similar to VSCode)
syntax on
colorscheme gruvbox
set background=dark
let g:gruvbox_contrast_dark = 'soft'


" Better Control+Backspace Handling (Delete Word)
inoremap <C-H> <C-W>

" Escape Key Mapping (Optional, Fast Exit Insert Mode)
inoremap jk <Esc>

