" #####  Start NeoBundle settings  #####

" Neobundleで管理するディレクトリの指定
set runtimepath+=~/.vim/bundle/neobundle.vim/

" 必要
call neobundle#begin(expand('~/.vim/bundle/'))

" NeoBundle自体をNeobundleで管理する
NeoBundleFetch 'Shougo/neobundle.vim'

" 追加のプラグインをここに書く
NeoBundle 'scrooloose/syntastic.git' " シンタックスチェック
NeoBundle 'scrooloose/nerdtree' " NERDTree と入力することでファイルをツリー状に表示する
NeoBundle 'miyakogi/seiya.vim' " :SeiyaEnable と入力することで背景を透明にする
NeoBundle 'Townk/vim-autoclose' " 括弧補完
NeoBundle 'itchyny/lightline.vim' " ステータスラインの装飾
NeoBundle 'nathanaelkane/vim-indent-guides'

call neobundle#end()
filetype plugin indent on
syntax on

" #####   End NeoBundle settings   #####

set encoding=utf-8
set fileencoding=utf-8
set number
set cursorline
set cursorcolumn
set ambiwidth=double
set tabstop=4
set expandtab
set shiftwidth=4
set smartindent
set autoindent
set list "visible whitespace
set virtualedit=block
set hidden
colorscheme gruvbox 
set background=dark
set statusline=2
set laststatus=2

" 起動時にコマンドを実行する
" autocmd vimenter * NERDTree | SeiyaEnable
autocmd vimenter * SeiyaEnable

nnoremap <silent><C-n> :NERDTreeToggle<CR>

" シンタックスチェック (syntasticの設定)
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2

" lightlineの設定
set t_Co=256
let g:lightline = {
    \ 'colorscheme': 'wombat'
    \ }

" vim-indent-guides
let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   ctermbg=241
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  ctermbg=235
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=1
