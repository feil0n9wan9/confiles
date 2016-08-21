" Copyright (c) 2016 Feilong Wang

" Permission is hereby granted, free of charge, to any person obtaining a copy
" of this software and associated documentation files (the "Software"), to deal
" in the Software without restriction, including without limitation the rights
" to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
" copies of the Software, and to permit persons to whom the Software is
" furnished to do so, subject to the following conditions:

" The above copyright notice and this permission notice shall be included in all
" copies or substantial portions of the Software.

" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
" IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
" FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
" LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
" OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
" SOFTWARE.


" Vundle plugin
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
"Plugin 'ascenator/L9', {'name': 'newL9'}

Plugin 'derekwyatt/vim-fswitch'
Plugin 'taglist.vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'easymotion/vim-easymotion'
Plugin 'Valloric/YouCompleteMe'
"Plugin 'nathanaelkane/vim-indent-guides'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Define leader key
let mapleader=";"

" Plugin Taglist
let Tlist_Auto_Open=1               "auto open tag list window
let Tlist_Show_One_File=1           "only show tag of current file
let Tlist_Exit_OnlyWindow=1         "auto exit Vim if tag list window is the only window
let Tlist_Use_Right_Window=1        "display in right
let Tlist_File_Fold_Auto_Close=1    "auto folding

" Plugin Vim-fswitch
nmap <silent> <Leader>sw :FSHere<CR>

" Plugin YouCompleteMe
"let g:ycm_error_symbol='>>'
"let g:ycm_warning_symbol='>*'
" Define keys to avoid conflict with UltiSnips
let g:ycm_key_list_select_completion=['<c-n>', '<Down>']
let g:ycm_key_list_previous_completion=['<c-p>', '<Up>']
" No need to confirm when load extra config file
let g:ycm_confirm_extra_conf=0
" Syntax identifiers completion
let g:ycm_seed_identifiers_with_syntax=1
" The fallback path to a config file which is used if no '.ycm_extra_conf.py' is found.
let g:ycm_global_ycm_extra_conf='~/.ycm_extra_conf.py'
" The defult completion key is ALT + /
let g:ycm_key_invoke_completion='<M-/>'
" Open completion in comments
let g:ycm_complete_in_comments=1
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Plugin UltiSnips
" Disable UltiSnips keys as we use YouCompleteMe
" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<c-f>"
" let g:UltiSnipsJumpBackwardTrigger="<c-b>"

" Plugin NERDTree
" Audo open NERDTree when open Vim
autocmd vimenter * NERDTree
" Auto close Vim if NERDTree window is the only window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") &&b:NERDTreeType == "primary") | q | endif

" Plugin Vim-cpp-enhanced-highlight
" Enable highlighting of class scope
let g:cpp_class_scope_highlight=1
" Workaround a vim issue with flagging braces as errors
let c_no_curly_error=1

" Plugin Vim-indent-guides
" Auto enable when open vim
"let g:indent_guides_enable_on_vim_startup=1
" Guide indent since level 2
"let g:indent_guides_start_level=2
" The width for guide symbol
"let g:indent_guides_guide_size=1

" Others
" Copy the selected content to system clipboard
vnoremap <Leader>y "+y
" Paste the content in system clipboard to cursor
nmap <Leader>p "+p
" Jump to left window
nnoremap <Leader>wh <c-w>h
" Jump to up window
nnoremap <Leader>wk <c-w>k
" Jump to right window
nnoremap <Leader>wl <c-w>l
" Jump to down window
nnoremap <Leader>wj <c-w>j

" Auto move cursor to edit area
wincmd w
autocmd VimEnter * wincmd w

" Auto reload vimrc when it changed
"autocmd BufWritePost $MYVIMRC source $MYVIMRC

" Enable man in vim
source $VIMRUNTIME/ftplugin/man.vim
nmap <Leader>man :Man 3 <cword><CR>

syntax on
set number                          "display line number
set autoindent                      "auto indentation
set smartindent                     "smart align
set completeopt=preview,menu        "auto complete
set clipboard+=unnamed              "share clipboard with system
set expandtab                       "expand tab as spaces
set tabstop=2                       "number of spaces a tab represents
set shiftwidth=2                    "shift tab as 4 spaces when formatting
set softtabstop=2                   "delete tabstop as one word in edit mode, even if it's expanded spaces
set incsearch                       "search right now
set ignorecase                      "search case insensitive
set wildmenu                        "auto completion in command line mode
set ruler                           "display cursor position
set cursorline
"hi CursorLine cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
