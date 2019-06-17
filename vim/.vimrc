" pluginがインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim
let s:dein_repo_dir = s:dein_dir . 'repos/github.com/Shougo/dein.vim'

" dein.vimがない時githubから落とす
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" dein settings
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " TOML file
  let g:rc_dir    = expand('~/.vim/rc')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " Load and cache
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " dein end
  call dein#end()
  call dein#save_state()
endif

" 未インストールのものがあったらインストール
if dein#check_install()
  call dein#install()
endif

" #####################################################################

" 一時的にファイルタイプを無効化
filetype off
filetype plugin indent off

" #####################################################################

" 基本設定
set fenc=utf-8
set number
set smartcase
set hlsearch
set showcmd
set laststatus=2
set wildmenu
set hidden
set autoread
set backspace=indent,eol,start
set cursorline
set textwidth=80
set colorcolumn=80
set formatoptions=q
" highlight Normal ctermbg=none

" 文字コード
set encoding=utf-8
set fileencoding=utf-8

" クリップボード
set clipboard+=unnamed

" 基本インデント
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set smartindent

" ファイルタイプ・インデント
augroup fileTypeIndent
  autocmd!
  " .vimrc
  autocmd BufNewFile,BufRead .vimrc setlocal tabstop=2 softtabstop=2 shiftwidth=2
  " HTML
  autocmd BufNewFile,BufRead *.html setlocal tabstop=2 softtabstop=2 shiftwidth=2
  " JS
  autocmd BufNewFile,BufRead *.js setlocal tabstop=2 softtabstop=2 shiftwidth=2
  " PHP
  autocmd BufNewFile,BufRead *.php setlocal tabstop=4 softtabstop=4 shiftwidth=4
  " C/C++
  autocmd BufNewFile,BufRead *.c setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.cpp setlocal tabstop=2 softtabstop=2 shiftwidth=2
  " Golang
  autocmd BufNewFile,BufRead *.go setlocal tabstop=2 softtabstop=2 shiftwidth=2
  " Python
  autocmd BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4
augroup END

" 折り返しに関する設定
set wrap
set linebreak
" set showbreak=+\ 
" Vim8以降
set breakindent

" 永続undo
if has('persistent_undo')
  set undodir=~/.vim/undo
  set undofile
endif


" #####################################################################
" Key bind
" #####################################################################

" ESCを2回押した時にハイライトを消す
nmap <silent> <Esc><Esc> :nohlsearch<CR>
" 検索後のジャンプ位置変更
nnoremap n nzz
nnoremap N Nzz
" Tabで対応するペアにジャンプ
nnoremap <Tab> %
vnoremap <Tab> %
" Ctrl + hjklでウィンドウ間を移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" w!!でスーパーユーザーとして保存
cmap w!! w !sudo tee > /dev/null %
" <C-e>でスクリプト実行
autocmd BufNewFile,BufRead *.py nnoremap <C-e> :!python %
autocmd BufNewFile,BufRead *.rb nnoremap <C-e> :!ruby%
" NERDTree
nnoremap <silent><C-m> :Ex<CR>

" #####################################################################
" Built-in plugin
" #####################################################################

" netrw - ファイラ
let g:netrw_liststyle=1
let g:netrw_banner=0
let g:netrw_sizestyle="H"
let g:netrw_timefmt="%Y/%m/%d(%a) %H:%M:%S"
let g:netrw_preview=1

" #####################################################################
" Plugin
" #####################################################################

" Lightline - ステータスバー装飾
let g:lightline = {
\   'colorscheme': 'wombat',
\   'mode_map': {'c': 'NORMAL'},
\   'active': {
\   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
\ },
\   'component': {
\   'readonly': '%{&readonly?"":""}',
\ },
\   'separator': { 'left': '', 'right': '' },
\   'subseparator': { 'left': '', 'right': '' },
\   'component_function': {
\   'modified': 'LightLineModified',
\   'readonly': 'LightLineReadonly',
\   'fugitive': 'LightLineFugitive',
\   'filename': 'LightLineFilename',
\   'fileformat': 'LightLineFileformat',
\   'filetype': 'LightLineFiletype',
\   'fileencoding': 'LightLineFileencoding',
\   'mode': 'LightLineMode'
\ }
\ }

function! LightLineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
  \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
  \  &ft == 'unite' ? unite#get_status_string() :
  \  &ft == 'vimshell' ? vimshell#get_status_string() :
  \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
  \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
    return fugitive#head()
  else
    return ''
  endif
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

" ALE - Async Linter
let g:ale_sign_column_always = 1
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow

let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1

let g:ale_linters = {
\  'python': ['flake8'],
\  'javascript': ['eslint'],
\}

let g:ale_fixers = {
\  'python': ['autopep8'],
\  'javascript': ['eslint'],
\}

" Jedi - Python all-in plugin
autocmd FileType python setlocal completeopt-=preview

" Seiya - Background transparent
let g:seiya_auto_enable=1

" Git gutter - git diff
if exists('&signcolumn')
  set signcolumn=yes
else
  let g:gitgutter_sign_column_always = 1
endif

let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = 'w'

" #####################################################################
" General
" #####################################################################
set t_Co=256
set background=dark
colorscheme pencil
filetype plugin indent on
syntax on
