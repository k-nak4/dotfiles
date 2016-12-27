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

" 一時的にファイルタイプを無効化
filetype off
filetype plugin indent off

" 基本設定
set number
set expandtab
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=iso-2022-jp,cp932,sjis,euc-jp,utf-8
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smartcase
set hlsearch
set autoindent
set smartindent
set showcmd
set laststatus=2
set wildmenu
set hidden
highlight Normal ctermbg=none

" 折り返しに関する設定
"set wrap
"set linebreak
"set showbreak=+\ 
"set breakindent

" キーバインド
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

" 自動起動
let g:syntastic_check_on_wq=0
let g:seiya_auto_enable=1
let g:neocomplete#enable_at_startup=1

" neocomplete
let g:neocomplete#enable_at_startup=1
inoremap <expr><CR> pumvisible() ? "<C-n>" . neocomplete#close_popup() : "<CR>"

" lightline
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

" syntastic
let g:syntastic_cpp_checkers = ['gcc']
let g:syntastic_cpp_compiler = 'gcc'
let g:syntastic_cpp_compiler_options = '-std=c++14'

" vim-indent-guides
let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   ctermbg=grey
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  ctermbg=darkgrey
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=1

" 無限undo
if has('persistent_undo')
  set undodir=~/.vim/undo
  set undofile
endif

" golang
let g:go_fmt_command="goimports"

" html
source $VIMRUNTIME/macros/matchit.vim

" C++に関する設定 +++++++++++++++++++++++++++++++++++++
augroup cpp-path
  autocmd!
  autocmd FileType cpp setlocal path=.,/usr/include,/usr/local/include
augroup END
" +++++++++++++++++++++++++++++++++++++++++++++++++++++

filetype plugin indent on
set t_Co=256
set background=dark
colorscheme lucius
syntax on
