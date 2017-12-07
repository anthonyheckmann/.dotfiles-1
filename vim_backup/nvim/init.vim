set encoding=utf-8
scriptencoding utf-8

augroup vimrc
  autocmd!
augroup END

let g:mapleader="\<Space>"

" Dein
if &compatible
  set nocompatible
endif


let g:python_host_prog = expand('~/.pyenv/versions/neovim2/bin/python')
let g:python3_host_prog = expand('~/.pyenv/versions/neovim3/bin/python')

let s:dein_dir = expand('~/.vim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif
execute 'set runtimepath^=' . s:dein_repo_dir
set runtimepath+=~/.config/nvim

call dein#begin(s:dein_dir)
call dein#load_toml('~/.vim/dein.toml', {'lazy': 0})
call dein#load_toml('~/.vim/dein_lazy.toml', {'lazy': 1})
call dein#end()

if dein#check_install()
  call dein#install()
endif

filetype plugin indent on

if has('vim_starting')
  runtime! userautoload/*.vim
endif
