" vim-plug
call plug#begin('~/.vim/plugged')

" plugin section
"Plug 'pangloss/vim-javascript'
"Plug 'leafgarland/typescript-vim'
"Plug 'maxmellon/vim-jsx-pretty'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'arcticicestudio/nord-vim'

" end vim-plug
call plug#end()

let g:deoplete#enable_at_startup = 1

map <C-n> :NERDTreeToggle<CR>

colorscheme nord

set number
set relativenumber
