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

Plugin 'a.vim'
Plugin 'taglist.vim'
Plugin 'cscope.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
"Plugin 'scrooloose/syntastic'
Plugin 'jiangmiao/auto-pairs'

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


" Taglist plugin
let Tlist_Auto_Open=1               "auto open tag list window
let Tlist_Show_One_File=1           "only show tag of current file
let Tlist_Exit_OnlyWindow=1         "auto exit Vim if tag list window is the only window
let Tlist_Use_Right_Window=1        "display in right
let Tlist_File_Fold_Auto_Close=1    "auto folding

" Cscope plugin
nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
" Redirect cscope output to Quickfix
set cscopequickfix=s-,c-,d-,i-,t-,e-

" YouCompleteMe plugin
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

" UltiSnips plugin
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<s-tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-tab>"

" NERDTree plugin
" Audo open NERDTree when open Vim
autocmd vimenter * NERDTree
" Auto close Vim if NERDTree window is the only window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") &&b:NERDTreeType == "primary") | q | endif

" Syntastic plugin
"let g:syntastic_check_on_open=1
let g:syntastic_cpp_include_dirs=['/usr/include/']
let g:syntastic_cpp_remove_include_errors =1
let g:syntastic_cpp_check_header=1
"let g:syntastic_cpp_compiler='clang++'
let g:syntastic_cpp_compiler_options='-std=c++11 -stdlib=libstdc++'
" Set error or warning signs
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
" Whether to show balloons
"let g:syntastic_enable_balloons=1"

" Auto-pairs plugin
let g:AutoPairsFlyMode = 1          "enable fly mode

" Others
" Auto move cursor to edit area
wincmd w
autocmd VimEnter * wincmd w
syntax on
set number                          "display line number
set autoindent                      "auto indentation
set smartindent                     "smart align
set completeopt=preview,menu        "auto complete
set clipboard+=unnamed              "share clipboard with system
set tabstop=4                       "tab offset
set expandtab                       "expand tab as 4 spaces
set shiftwidth=4                    "4 spaces for auto indentation
set softtabstop=4                   "delete tabstop as one word in edit mode, even if it's expanded spaces
set incsearch                       "search right now
set cursorline
"hi CursorLine cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white

