" ============================================================================
" Basics & Display
" ============================================================================
set nocompatible               " Disable legacy Vi compatibility
set novisualbell               " Disable visual bell
set mouse=a                    " Enable mouse
syntax on                      " Enable syntax highlighting
set encoding=utf-8             " Set UTF-8 text encoding
set number                     " Show current line number
set relativenumber             " Show relative line numbers for easier jumps
set scrolloff=8                " Keep 8 lines visible above/below cursor
set laststatus=2               " Always display the status line
set wildmenu                   " Enhanced command-line completion menu
set background=dark            " Force dark mode

" ============================================================================
" Indentation & Tabs
" ============================================================================
filetype plugin indent on      " Enable filetype detection, plugins and indent
set expandtab                  " Convert tabs into spaces
set tabstop=4                  " Number of visual spaces per tab
set shiftwidth=4               " Number of spaces for auto-indent and >> / <<
set softtabstop=4              " Number of spaces per tab while editing
set smartindent                " Automatically indent new lines

" ============================================================================
" Search
" ============================================================================
set incsearch                  " Search incrementally as you type
set hlsearch                   " Highlight all search matches
set ignorecase                 " Ignore case when searching
set smartcase                  " Case-sensitive if search contains uppercase

" ============================================================================
" Files, Undo & Buffers
" ============================================================================
set hidden                     " Allow switching buffers without saving
set history=1000               " Remember more command and search history
set backspace=indent,eol,start " Make backsp work intuitively in insert mode

" ============================================================================
" Key Mappings
" ============================================================================
let mapleader = " "            " Set Space as the leader key
nnoremap <leader>h :nohlsearch<CR> " Clear search highlights
