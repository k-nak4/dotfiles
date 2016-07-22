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
  let g:rc_dir    = expand('~/.config/nvim/rc')
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

" settings
set number
set expandtab
set encoding=utf-8
set fileencoding=utf-8
set tabstop=4
set softtabstop=4
set shiftwidth=4
