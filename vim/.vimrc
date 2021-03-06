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
set numberwidth=4
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
set showtabline=2
set ambiwidth=double
highlight Normal ctermbg=none

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
  " dotfiles
  autocmd BufNewFile,BufRead .* setlocal tabstop=2 softtabstop=2 shiftwidth=2
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
  autocmd BufNewFile,BufRead *.go setlocal tabstop=4 softtabstop=4 shiftwidth=4 | set noexpandtab
  " Python
  autocmd BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4
augroup END

" 折り返しに関する設定
set wrap
set linebreak
" set showbreak=+\ 
set breakindent

" 永続undo
if has('persistent_undo')
  set undodir=~/.vim/undo
  set undofile
endif

" #####################################################################
" Key bind
" #####################################################################

" ESC -> jj & autosave
inoremap <silent> jj <ESC>
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
\     'left': [['mode', 'paste'], ['fugitive', 'filename']]
\   },
\   'component': {
\     'readonly': '%{&readonly?"":""}',
\   },
\ }

" lightline - Bufferline
let g:lightline#bufferline#show_number=1
let g:lightline#bufferline#shorten_path=0
let g:lightline#bufferline#unnamed='[No Name]'
let g:lightline.tabline = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type = {'buffers': 'tabsel'}

" ALE - Async Linter
let g:ale_sign_column_always = 1
let g:ale_sign_error = 'x'
let g:ale_sign_warning = 'w'

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

" vim-go
let g:go_template_autocreate=1
let g:go_term_mode="split"
let g:go_fmt_command="goimports"

" Indent guides
let g:indent_guides_enable_on_vim_startup=0

" LSP
if empty(globpath(&rtp, 'autoload/lsp.vim'))
  finish
endif

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  nmap <buffer> gd <plug>(lsp-definition)
  nmap <buffer> <f2> <plug>(lsp-rename)
  inoremap <expr> <cr> pumvisible() ? "\<c-y>\<cr>" : "\<cr>"
endfunction

augroup lsp_install
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
command! LspDebug let lsp_log_verbose=1 | let lsp_log_file = expand('~/lsp.log')

let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 1
let g:asyncomplete_popup_delay = 200
let g:lsp_text_edit_enabled = 0

" #####################################################################
" General
" #####################################################################
set t_Co=256
set background=dark
colorscheme gruvbox
filetype plugin indent on
syntax on
