set rtp+=/usr/share/vim/vimfiles/plugin/powerline.vim
set laststatus=2
set t_Co=256

syntax on
filetype plugin indent on
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
set number
set autoindent
set tabstop=4 
set expandtab 
set shiftwidth=4 
set softtabstop=4
set cursorline
set foldenable

let python_highlight_all = 1

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_loc_list_height=5
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

autocmd BufWritePre * %s/\s\+$//e

