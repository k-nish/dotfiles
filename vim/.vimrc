filetype plugin indent on
syntax enable
syntax on
"colorscheme molokai
"colorscheme tender
"colorscheme koehler
"colorscheme elflord
"colorscheme spring-night
"colorscheme rdark
let g:airline_theme = 'tender'
let g:molokai_original = 1
let g:rehash256 = 1
set t_Co=256
let g:rdark_current_line = 1

"escをCommand + kに設定
noremap <C-k> <esc>
noremap! <C-k> <esc>
vnoremap <C-k> <esc>
inoremap <C-k> <esc>
map <C-k> <esc>

"buffer移動"
map gn :bn<cr>
map gu :bp<cr>
map gd :bd<cr>

"行末のスペースを削除
autocmd BufWritePre * :%s/\s\+$//ge

"最終行の空白を削除
autocmd BufWritePre * call s:remove_line_in_last_line()

filetype plugin indent on
set background=dark
"set clipboard+=unnamed,autoselect
set clipboard+=unnamed
set relativenumber
set number
set title
"set softtabstop=4
set noexpandtab
set smarttab
set hlsearch
set backspace=indent,eol,start
set ruler
"set cursorline
"set cursorcolumn

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

let s:cpo_save = &cpo
set cpo&vim

syn match pythonOperator "\(+\|=\|-\|\^\|\*\)"
syn match pythonDelimiter "\(,\|\.\|:\)"
syn keyword pythonSpecialWord self

hi link pythonSpecialWord    Special
hi link pythonDelimiter      Special

let b:current_after_syntax = 'python'

let &cpo = s:cpo_save
unlet s:cpo_save

set showtabline=2

if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
:autocmd InsertEnter * set cul
:autocmd InsertLeave * set nocul
