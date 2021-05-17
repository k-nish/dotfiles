if !&compatible
      set nocompatible
endif

"reset augroup
augroup MyAutoCmd
    autocmd!
augroup END

"dein settings {{{
" dein自体の自動インストール
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
    call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath
" プラグイン読み込み＆キャッシュ作成
let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir, [$MYVIMRC, s:toml_file])
    call dein#load_toml(s:toml_file)
    call dein#end()
    call dein#save_state()
endif
" 不足プラグインの自動インストール
if has('vim_starting') && dein#check_install()
  call dein#install()
endif
" }}
set runtimepath+=$HOME/.config/nvim/plugins/repos/github.com/Shougo/dein.vim
if dein#load_state(expand('~/.config/nvim/plugins'))
  call dein#begin(expand('~/.config/nvim/plugins'))
  call dein#add('Shougo/dein.vim')
  call dein#add('Shougo/denite.nvim')
  call dein#add('tbodt/deoplete-tabnine', { 'build': './install.sh' })
  call dein#end()
  call dein#save_state()
endif
if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
syntax enable
syntax on
" colorscheme molokai
"colorscheme koehler
"colorscheme elflord
"colorscheme spring-night
"colorscheme vividchalk
"colorscheme tender
" colorscheme candy
colorscheme badwolf
" colorscheme eldar
" colorscheme gruvbox
" let g:gruvbox_contrast_dark = 'hard'
let g:molokai_original = 1
let g:rehash256 = 1
set t_Co=256
let g:airline_theme = 'dark'
"let g:rdark_current_line = 1

set ttimeout
set ttimeoutlen=50

" ノーマルモード時だけ ; と : を入れ替える
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

"行頭移動を-にする
nnoremap - ^
vnoremap - ^

"行末移動を=にする
nnoremap = $
vnoremap = $

let mapleader = ","

"escをCommand + kに設定
noremap <C-f> <esc>
noremap! <C-f> <esc>
vnoremap <C-f> <esc>
inoremap <C-f> <esc>
map <C-f> <esc>

"buffer移動"
map <C-h> ;bp<cr>
map <C-l> ;bn<cr>
"map <F4> ;bd<cr>

"hidden latest highlight
map <Leader>g ;noh<cr>

"行末のスペースを削除
aug space
    " 重複登録回避 - `:h aug` 参照
    au!
    " autocmd BufWritePre * :%s/\s\s*$
    autocmd BufWritePre * :FixWhitespace
aug END
"autocmd BufWritePre * :%s/\s\+$//ge

"最終行の空白を削除
"autocmd BufWritePre * call s:remove_line_in_last_line()

filetype plugin indent on
set background=dark
"set clipboard+=unnamed,autoselect
set clipboard+=unnamed
" set relativenumber
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

set colorcolumn=80

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

" Statuslineの設定
set laststatus=2
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ \[ENC=%{&fileencoding}]%P

" 画面分割
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sn gt
nnoremap sp gT
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap sT :<C-u>Unite tab<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>
nnoremap sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
nnoremap sB :<C-u>Unite buffer -buffer-name=file<CR>

call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')
call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')
call submode#map('bufmove', 'n', '', '>', '<C-w>>')
call submode#map('bufmove', 'n', '', '<', '<C-w><')
call submode#map('bufmove', 'n', '', '+', '<C-w>+')
call submode#map('bufmove', 'n', '', '-', '<C-w>-')

" terminal
if has('nvim')
  " Neovim 用
  autocmd WinEnter * if &buftype ==# 'terminal' | startinsert | endif
else
  " Vim 用
  autocmd WinEnter * if &buftype ==# 'terminal' | normal i | endif
endif

tnoremap <Esc> <C-\><C-n>

nnoremap ,t :terminal<CR>

" let g:python_host_prog = '/usr/bin/python2'
" let g:python3_host_prog = '/usr/bin/python3'

" if exists("$VIRTUAL_ENV")
"   if !empty(glob("$VIRTUAL_ENV/bin/python3"))
"     let g:python3_host_prog = substitute(system("which python"), '\n', '', 'g')
"   else
"     let g:python_host_prog = substitute(system("which python"), '\n', '', 'g')
"   endif
" endif

"---------------------------------
" startify
"---------------------------------
let g:startify_files_number = 5
let g:startify_list_order = [
        \ ['♻  最近使ったファイル:'],
        \ 'files',
        \ ['♲  最近使ったファイル(カレントディレクトリ下):'],
        \ 'dir',
        \ ['⚑  セッション:'],
        \ 'sessions',
        \ ['☺  ブックマーク:'],
        \ 'bookmarks',
        \ ]
let g:startify_bookmarks = ["~/.config/nvim/init.vim", "~/.config/nvim/dein.toml", "~/.zshrc"]
let g:startify_session_autoload = 1
nnoremap <silent> <C-p> :Startify<CR>



"-----------------------------------
"vim-flake8
"-----------------------------------
let g:flake8_show_quickfix=0
" to use colors defined in the colorscheme
highlight link Flake8_Error      Error
highlight link Flake8_Warning    WarningMsg
highlight link Flake8_Complexity WarningMsg
highlight link Flake8_Naming     WarningMsg
highlight link Flake8_PyFlake    WarningMsg
" let g:flake8_ignore = "E501, W293"

"-----------------------------------
"vimfiler
"-----------------------------------
""vimデフォルトのエクスプローラをvimfilerで置き換える
"let g:vimfiler_as_default_explorer = 1
""セーフモードを無効にした状態で起動する
"let g:vimfiler_safe_mode_by_default = 0
""現在開いているバッファのディレクトリを開く
"nnoremap <silent> <Leader>fe :<C-u>VimFilerBufferDir -quit<CR>
""現在開いているバッファをIDE風に開く
"nnoremap <silent> <Leader>fi :<C-u>VimFilerBufferDir -split -simple -winwidth=35 -no-quit<CR>
"
""デフォルトのキーマッピングを変更
"augroup vimrc
"  autocmd FileType vimfiler call s:vimfiler_my_settings()
"augroup END
"function! s:vimfiler_my_settings()
"  nmap <buffer> q <Plug>(vimfiler_exit)
"  nmap <buffer> Q <Plug>(vimfiler_hide)
"endfunction
"
"" vimfiler
""" 自動起動
"autocmd VimEnter * VimFiler -split -simple -winwidth=25 -no-quit
""" [:e .]のように気軽に起動できるようにする
let g:vimfiler_as_default_explorer = 1
""" セーフモードの設定(OFF
"let g:vimfiler_safe_mode_by_default=0
"
"" netrwは常にtree view
"let g:netrw_liststyle = 3
"" 'v'でファイルを開くときは右側に開く。(デフォルトが左側なので入れ替え)
"let g:netrw_altv = 1
"" 'o'でファイルを開くときは下側に開く。(デフォルトが上側なので入れ替え)
"let g:netrw_alto = 1
"" 'v'や'o'で開かれる新しいウィンドウのサイズを指定する
"let g:netrw_winsize = 80
"nnoremap <silent> ,f :VimFiler<CR>
" nnoremap <silent> ,s :VimShellPop<CR>
"
"buffer directory
"nnoremap <silent> fe :VimFilerBufferDir -quit<CR>
" Nerdtree like
nnoremap <C-e> :VimFilerBufferDir -split -winwidth=25 -toggle -no-quit<CR>

scriptencoding utf-8
let g:vimfiler_as_default_explorer = get(g:, 'vimfiler_as_default_explorer', 1)
let g:vimfiler_restore_alternate_file = get(g:, 'vimfiler_restore_alternate_file', 1)
let g:vimfiler_tree_indentation = get(g:, 'vimfiler_tree_indentation', 1)
let g:vimfiler_tree_leaf_icon = get(g:, 'vimfiler_tree_leaf_icon', '')
let g:vimfiler_tree_opened_icon = get(g:, 'vimfiler_tree_opened_icon', '▼')
let g:vimfiler_tree_closed_icon = get(g:, 'vimfiler_tree_closed_icon', '▷')
let g:vimfiler_file_icon = get(g:, 'vimfiler_file_icon', '')
let g:vimfiler_readonly_file_icon = get(g:, 'vimfiler_readonly_file_icon', '*')
let g:vimfiler_marked_file_icon = get(g:, 'vimfiler_marked_file_icon', '√')
"let g:vimfiler_preview_action = 'auto_preview'
let g:vimfiler_ignore_pattern = [
      \ '^\.git$',
      \ '^\.DS_Store$',
      \ '^\.init\.vim-rplugin\~$',
      \ '^\.netrwhist$',
      \ '\.class$'
      \]

if has('mac')
  let g:vimfiler_quick_look_command =
        \ '/Applications//Sublime\ Text.app/Contents/MacOS/Sublime\ Text'
else
  let g:vimfiler_quick_look_command = 'gloobus-preview'
endif

if has('mac')
  let g:vimfiler_quick_look_command =
        \ '/Applications//Sublime\ Text.app/Contents/MacOS/Sublime\ Text'
else
  let g:vimfiler_quick_look_command = 'gloobus-preview'
endif
function! s:setcolum() abort
  if g:spacevim_enable_vimfiler_filetypeicon && !g:spacevim_enable_vimfiler_gitstatus
    return 'filetypeicon'
  elseif !g:spacevim_enable_vimfiler_filetypeicon && g:spacevim_enable_vimfiler_gitstatus
    return 'gitstatus'
  elseif g:spacevim_enable_vimfiler_filetypeicon && g:spacevim_enable_vimfiler_gitstatus
    return 'filetypeicon:gitstatus'
  else
    return ''
  endif
endfunction
"try
call vimfiler#custom#profile('default', 'context', {
      \ 'explorer' : 1,
      \ 'winwidth' : 25,
      \ 'winminwidth' : 25,
      \ 'toggle' : 1,
      \ 'auto_expand': 1,
      \ 'direction' : 'rightbelow',
      \ 'parent': 0,
      \ 'status' : 1,
      \ 'safe' : 0,
      \ 'split' : 1,
      \ 'hidden': 1,
      \ 'no_quit' : 1,
      \ 'force_hide' : 0,
      \ })

"catch
"endtry
augroup vfinit
  au!
  autocmd FileType vimfiler call s:vimfilerinit()
  autocmd BufEnter * if (winnr('$') == 1 && &filetype ==# 'vimfiler') |
        \ q | endif
augroup END
function! s:vimfilerinit()
  set nonumber
  set norelativenumber

  silent! nunmap <buffer> <Leader>
  silent! nunmap <buffer> <C-l>
  silent! nunmap <buffer> <C-j>
  silent! nunmap <buffer> E
  silent! nunmap <buffer> gr
  silent! nunmap <buffer> gf
  silent! nunmap <buffer> -
  silent! nunmap <buffer> s

  nnoremap <silent><buffer> gr  :<C-u>Denite grep:<C-R>=<SID>selected()<CR> -buffer-name=grep<CR>
  nnoremap <silent><buffer> gf  :<C-u>Denite file_rec:<C-R>=<SID>selected()<CR><CR>
  nnoremap <silent><buffer> gd  :<C-u>call <SID>change_vim_current_dir()<CR>
  nnoremap <silent><buffer><expr> sg  vimfiler#do_action('vsplit')
  nnoremap <silent><buffer><expr> sv  vimfiler#do_action('split')
  nnoremap <silent><buffer><expr> st  vimfiler#do_action('tabswitch')
  nmap <buffer> gx     <Plug>(vimfiler_execute_vimfiler_associated)
  nmap <buffer> '      <Plug>(vimfiler_toggle_mark_current_line)
  nmap <buffer> v      <Plug>(vimfiler_quick_look)
  nmap <buffer> p      <Plug>(vimfiler_preview_file)
  nmap <buffer> V      <Plug>(vimfiler_clear_mark_all_lines)
  nmap <buffer> i      <Plug>(vimfiler_switch_to_history_directory)
  nmap <buffer> <Tab>  <Plug>(vimfiler_switch_to_other_window)
  nmap <buffer> <C-r>  <Plug>(vimfiler_redraw_screen)
endf

"-----------------------------------
"indentLine
"-----------------------------------
set expandtab
set list listchars=tab:\¦\

let g:indentLine_faster = 1
let g:indentLine_color_term = 111
let g:indentLine_color_gui = '#708090'
let g:indentLIne_char = '|' "use |
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'tagbar', 'unite']
nnoremap <silent> <F2> : IndentLinesToggle <CR>


"---------------------------------
"jedi-vim
"---------------------------------
autocmd FileType python setlocal omnifunc=jedi#completions
let g:jedi#completions_enabled = 1
let g:jedi#auto_vim_configuration = 0
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#popup_on_dot = 0
let g:jedi#goto_command = "<C-i>"
let g:jedi#goto_assignments_command = "<C-g>"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<C-n>"
let g:jedi#rename_command = "<C-r>"
autocmd FileType python setlocal completeopt-=preview

if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
endif

"---------------------------------
"deoplete
"---------------------------------
let g:deoplete#enable_at_startup = 1
" disable autocomplete by default
let g:deoplete_disable_auto_complete=1
let g:deoplete#enable_camel_case = 0
let g:deoplete#enable_ignore_case = 0
let g:deoplete#enable_smart_case = 1
let g:deoplete#max_abbr_width=0
let g:deoplete#max_menu_width=0
let g:echodoc_enable_at_startup=1

let g:deoplete#auto_complete_delay = 0
let g:deoplete#max_list = 10000
let g:deoplete#file#enable_buffer_path = 1
let g:deoplete#enable_refresh_always = 0
let g:deoplete#auto_complete_start_length = 1


let g:deoplete#sources = {}

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"

"---------------------------------
"vim-airline
"---------------------------------
let g:airline#extensions#tabline#enabled = 1

""---------------------------------
""ctrlp
""---------------------------------
""Prefix: s
"nnoremap s <Nop>
"nnoremap sa :<C-p>CtrlP<Leader>
"nnoremap sb :<C-p>CtrlPBuffer<CR>
"nnoremap sd :<C-p>CtrlPDir<CR>
"nnoremap sf :<C-p>CtrlP<CR>
"nnoremap sl :<C-p>CtrlPLine<CR>
"nnoremap sm :<C-p>CtrlPMRUFiles<CR>
"nnoremap sq :<C-p>CtrlPQuickfix<CR>
"nnoremap ss :<C-p>CtrlPMixed<CR>
"nnoremap st :<C-p>CtrlPTag<CR>
"
"let g:ctrlp_map = '<Nop>'
"" Guess vcs root dir
"let g:ctrlp_working_path_mode = 'ra'
"" Open new file in current window
"let g:ctrlp_open_new_file = 'r'
"let g:ctrlp_extensions = ['tag', 'quickfix', 'dir', 'line', 'mixed']
"let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:18'


"---------------------------------
"unite
"---------------------------------
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200
nnoremap <silent> ,uy :<C-u>Unite history/yank<CR>
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files fLeader><CR>
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> ,uu :<C-u>Unite file_mru buffer<CR>
nnoremap <silent> <C-k> :Unite file<CR>

"---------------------------------
" startify
"---------------------------------
let g:startify_files_number = 5
let g:startify_list_order = [
        \ ['♻  最近使ったファイル:'],
        \ 'files',
        \ ['♲  最近使ったファイル(カレントディレクトリ下):'],
        \ 'dir',
        \ ['⚑  セッション:'],
        \ 'sessions',
        \ ['☺  ブックマーク:'],
        \ 'bookmarks',
        \ ]
let g:startify_bookmarks = ["~/.config/nvim/init.vim", "~/.config/nvim/dein.toml"]
let g:startify_session_autoload = 1


"---------------------------------
" w0rp/ale
"---------------------------------

" エラー行に表示するマーク
let g:ale_sign_error = '⨉'
let g:ale_sign_warning = '⚠'
" エラー行にカーソルをあわせた際に表示されるメッセージフォーマット
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" エラー表示の列を常時表示
let g:ale_sign_column_always = 1

" ファイルを開いたときにlint実行
let g:ale_lint_on_enter = 1
" ファイルを保存したときにlint実行
let g:ale_lint_on_save = 1
" 編集中のlintはしない
let g:ale_lint_on_text_changed = 'never'
" ファイル保存時に自動的にfixする
let g:ale_fix_on_save = 1

" lint結果をロケーションリストとQuickFixには表示しない
" 出てると結構うざいしQuickFixを書き換えられるのは困る
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 0
let g:ale_open_list = 0
let g:ale_keep_list_window_open = 0

" 有効にするlinter
let g:ale_linters = {
\   'python': ['flake8'],
\}

" 各ツールをFixerとして登録
let g:ale_fixers = {
\    '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['black'],
\}

"ついでにFIxを実行するマッピングしとく
nmap <silent> <C-x> <Plug>(ale_fix)

" ALE用プレフィックス
nmap [ale] <Nop>
map <C-m> [ale]
" エラー行にジャンプ
nmap <silent> [ale]<C-P> <Plug>(ale_previous)
nmap <silent> [ale]<C-N> <Plug>(ale_next)


call map(dein#check_clean(), "delete(v:val, 'rf')")


"---------------------------------
" fugitive.vim
"---------------------------------
nnoremap <silent> <C-b> :Gblame<CR>
nnoremap <silent> <Leader>d :Gdiff<CR>
nnoremap <silent> <C-s> :Gstatus<CR>
nnoremap <silent> <Leader>a :Gwrite<CR>
nnoremap <silent> <Leader>c :Gcommit<CR>
"command-line completion
set wildmenu
set wildmode=list:longest

let g:badwolf_tabline = 3


"--------------------------------
"rust.vim
"--------------------------------
let g:rustfmt_autosave = 1


"--------------------------------
"tagber
"--------------------------------
nnoremap <C-o> :TagbarToggle<CR>


"--------------------------------
"vim-commentary
"--------------------------------
nnoremap <Leader>r :gc<CR>
autocmd FileType apache setlocal commentstring=#\ %s

"--------------------------------
"rainbow
"--------------------------------
let g:rainbow_active = 1
let g:rainbow_conf = {
\    'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
\    'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
\    'operators': '_,_',
\    'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\    'separately': {
\        '*': {},
\        'tex': {
\            'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
\        },
\        'python': {
\            'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
\        },
\        'vim': {
\            'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
\        },
\        'html': {
\            'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
\        },
\        'css': 0,
\    }
\}

"--------------------------------
"python-syntax
"--------------------------------
let g:python_highlight_all = 1

"--------------------------------
"SuperTab
"--------------------------------
let g:SuperTabDefaultCompletionType = "<c-n>"

"--------------------------------
"vim-pydocstring
"--------------------------------
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
nmap <silent> <C-c> <Plug>(pydocstring)
let g:pydocstring_formatter = 'google'
let g:pydocstring_doq_path = '/usr/local/bin/doq'
