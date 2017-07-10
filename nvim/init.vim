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
" }}}

filetype plugin indent on
syntax enable
syntax on
"colorscheme molokai
"colorscheme tender
"colorscheme koehler
"colorscheme elflord
"colorscheme spring-night
colorscheme rdark
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


"-----------------------------------
"syntastic
"-----------------------------------
let g:syntastic_python_checkers = ['flake8']
autocmd BufWritePost *.py call Flake8()
let g:syntastic_check_on_open=1

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
autocmd VimEnter * VimFiler -split -simple -winwidth=25 -no-quit
""" [:e .]のように気軽に起動できるようにする
"let g:vimfiler_as_default_explorer = 1
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
nnoremap <silent> ,f :VimFiler<CR>
" nnoremap <silent> ,s :VimShellPop<CR>
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

  silent! nunmap <buffer> <Space>
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
nnoremap <silent> <C-w> : IndentLinesToggle <CR>

"-----------------------------------
"Previm
"-----------------------------------
augroup PrevimSettings
    autocmd!
    autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END

let g:previm_open_cmd = 'open -a Chrome'
nnoremap <silent> <C-m> :PrevimOpen<CR> " Ctrl-pでプレビュー
let g:previm_open_cmd = 'open -a /Applications/Google\ Chrome.app'
let g:vim_markdown_folding_disabled=1

"行末のスペースを削除
autocmd BufWritePre * :%s/\s\+$//ge

"最終行の空白を削除
autocmd BufWritePre * call s:remove_line_in_last_line()

function! s:remove_line_in_last_line()
  if getline('$') == ""
     $delete _
  endif
endfunction

"---------------------------------
"jedi-vim
"---------------------------------
autocmd FileType python setlocal omnifunc=jedi#completions
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#popup_on_dot = 0
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#rename_command = "<leader>R"
autocmd FileType python setlocal completeopt-=preview

if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
endif

"---------------------------------
"deoplete
"---------------------------------
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 0
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#enable_camel_case = 0
let g:deoplete#enable_ignore_case = 0
let g:deoplete#enable_refresh_always = 0
let g:deoplete#enable_smart_case = 1
let g:deoplete#file#enable_buffer_path = 1
let g:deoplete#max_list = 10000
" deoplete tab-complete
inoremap <expr><C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-j>  deoplete#mappings#manual_complete()
inoremap <expr> <C-j>  pumvisible() ? "\<C-n>" : deoplete#mappings#manual_complete()
inoremap <expr> <C-h> pumvisible() ? "\<C-p>" : "\<C-u>"

" inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" inoremap <expr> <Tab>  deoplete#mappings#manual_complete()
" inoremap <expr> <Tab>  pumvisible() ? "\<C-n>" : deoplete#mappings#manual_complete()
" inoremap <expr> <S-Tab>  pumvisible() ? "\<C-p>" : "\<S-Tab>"
"---------------------------------
"deoplete-jedi
"---------------------------------
let g:deoplete#enable_at_startup = 1

"---------------------------------
"vim-airline
"---------------------------------
let g:airline#extensions#tabline#enabled = 1

"---------------------------------
"ctrlp
"---------------------------------
"Prefix: s
nnoremap s <Nop>
nnoremap sa :<C-u>CtrlP<Space>
nnoremap sb :<C-u>CtrlPBuffer<CR>
nnoremap sd :<C-u>CtrlPDir<CR>
nnoremap sf :<C-u>CtrlP<CR>
nnoremap sl :<C-u>CtrlPLine<CR>
nnoremap sm :<C-u>CtrlPMRUFiles<CR>
nnoremap sq :<C-u>CtrlPQuickfix<CR>
nnoremap ss :<C-u>CtrlPMixed<CR>
nnoremap st :<C-u>CtrlPTag<CR>

let g:ctrlp_map = '<Nop>'
" Guess vcs root dir
let g:ctrlp_working_path_mode = 'ra'
" Open new file in current window
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_extensions = ['tag', 'quickfix', 'dir', 'line', 'mixed']
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:18'


"---------------------------------
"unite
"---------------------------------
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200
nnoremap <silent> ,uy :<C-u>Unite history/yank<CR>
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> ,uu :<C-u>Unite file_mru buffer<CR>

"---------------------------------
"startify
"---------------------------------
"autocmd BufEnter * if !exists('t:startified') | Startify | let t:startified = 1 | endif
"let g:startify_disable_at_vimenter = 1
"let g:startify_custom_header = get(g:, 'startify_custom_header', [
"      \'',
"      \'',
"      \'        /######                                     /##    /##/##             ',
"      \'       /##__  ##                                   | ##   | #|__/             ',
"      \'      | ##  \__/ /######  /######  /####### /######| ##   | ##/##/######/#### ',
"      \'      |  ###### /##__  ##|____  ##/##_____//##__  #|  ## / ##| #| ##_  ##_  ##',
"      \'       \____  #| ##  \ ## /######| ##     | ########\  ## ##/| #| ## \ ## \ ##',
"      \'       /##  \ #| ##  | ##/##__  #| ##     | ##_____/ \  ###/ | #| ## | ## | ##',
"      \'      |  ######| #######|  ######|  ######|  #######  \  #/  | #| ## | ## | ##',
"      \'       \______/| ##____/ \_______/\_______/\_______/   \_/   |__|__/ |__/ |__/',
"      \'               | ##                                                           ',
"      \'               | ##                                                           ',
"      \'               |__/                                                           ',
"      \'',
"      \ ])
"let g:startify_session_dir = $HOME .  '/.data/' . ( has('nvim') ? 'nvim' : 'vim' ) . '/session'
"let g:startify_files_number = 6
"let g:startify_list_order = [
"      \ ['   My most recently used files in the current directory:'],
"      \ 'dir',
"      \ ['   My most recently used files:'],
"      \ 'files',
"      \ ['   These are my sessions:'],
"      \ 'sessions',
"      \ ['   These are my bookmarks:'],
"      \ '~/.config/nvim/init.vim',
"      \ '~/.config/nvim/dein.toml',
"      \ ]
"let g:startify_update_oldfiles = 1
"let g:startify_disable_at_vimenter = 1
"let g:startify_session_autoload = 1
"let g:startify_session_persistence = 1
""let g:startify_session_delete_buffers = 0
"let g:startify_change_to_dir = 0
""let g:startify_change_to_vcs_root = 0  " vim-rooter has same feature
"let g:startify_skiplist = [
"      \ 'COMMIT_EDITMSG',
"      \ escape(fnamemodify(resolve($VIMRUNTIME), ':p'), '\') .'doc',
"      \ 'bundle/.*/doc',
"      \ ]
"fu! <SID>startify_mapping()
"  if getcwd() == $VIM || getcwd() == expand('~')
"    nnoremap <silent><buffer> <c-p> :<c-u>CtrlP ~\DotFiles<cr>
"  endif
"endf
"augroup startify_map
"  au!
"  autocmd FileType startify nnoremap <buffer><F2> <Nop>
"  autocmd FileType startify call <SID>startify_mapping()
"  autocmd FileType startify set scrolloff=0
"augroup END

function! s:GetVisual()
    let [lnum1, col1] = getpos("'<")[1:2]
    let [lnum2, col2] = getpos("'>")[1:2]
    let lines = getline(lnum1, lnum2)
    let lines[-1] = lines[-1][:col2 - 2]
    let lines[0] = lines[0][col1 - 1:]
    return lines
endfunction

function! REPLSend(lines)
    call jobsend(g:last_terminal_job_id, add(a:lines, ''))
endfunction
" }}}
" Commands {{{
" REPL integration {{{
command! -range=% REPLSendSelection call REPLSend(s:GetVisual())
command! REPLSendLine call REPLSend([getline('.')])
" }}}
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
"silent! let &t_SI = "\<Esc>]50;CursorShape=1\x7"
"silent! let &t_SR = "\<Esc>]50;CursorShape=2\x7"
"silent! let &t_EI = "\<Esc>]50;CursorShape=0\x7"
" dark0 + gray
let g:terminal_color_0 = '#282828'
let g:terminal_color_8 = '#928374'

" neurtral_red + bright_red
let g:terminal_color_1 = '#cc241d'
let g:terminal_color_9 = '#fb4934'

" neutral_green + bright_green
let g:terminal_color_2 = '#98971a'
let g:terminal_color_10 = '#b8bb26'

" neutral_yellow + bright_yellow
let g:terminal_color_3 = '#d79921'
let g:terminal_color_11 = '#fabd2f'

" neutral_blue + bright_blue
let g:terminal_color_4 = '#458588'
let g:terminal_color_12 = '#83a598'

" neutral_purple + bright_purple
let g:terminal_color_5 = '#b16286'
let g:terminal_color_13 = '#d3869b'

" neutral_aqua + faded_aqua
let g:terminal_color_6 = '#689d6a'
let g:terminal_color_14 = '#8ec07c'

" light4 + light1
let g:terminal_color_7 = '#a89984'
let g:terminal_color_15 = '#ebdbb2'
augroup Terminal
    au!
    au TermOpen * let g:last_terminal_job_id = b:terminal_job_id | IndentLinesDisable
    au BufWinEnter term://* startinsert | IndentLinesDisable
    au TermClose * let g:_spacevim_termclose_abuf = expand('<abuf>') | call SpaceVim#mapping#close_term_buffer()
augroup END
augroup nvimrc_aucmd
    autocmd!
    autocmd CursorHold,FocusGained,FocusLost * rshada|wshada
augroup END
