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
set tabstop=2
set softtabstop=2
set shiftwidth=2
set smartcase
set hlsearch
set autoindent
set smartindent
set showcmd
set laststatus=2
set wildmenu
highlight Normal ctermbg=none

" 折り返しに関する設定
set wrap
set linebreak
set showbreak=+\ 
set breakindent

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
\ 'colorscheme': 'solarized',
\ }

" syntastic
let g:syntastic_cpp_checkers = ['gcc']
let g:syntastic_cpp_compiler = 'gcc'
let g:syntastic_cpp_compiler_options = '-std=c++14'

" 無限undo
if has('persistent_undo')
  set undodir=~/.vim/undo
  set undofile
endif

" C++に関する設定 +++++++++++++++++++++++++++++++++++++
augroup cpp-path
  autocmd!
  autocmd FileType cpp setlocal path=.,/usr/include,/usr/local/include
augroup END
" +++++++++++++++++++++++++++++++++++++++++++++++++++++

filetype plugin indent on
set t_Co=256
set background=light
colorscheme codeschool
syntax on
