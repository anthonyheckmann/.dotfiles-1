set encoding=utf-8
scriptencoding utf-8

" NeoBundle {{{1
" Initialization {{{2
if !1 | finish | endif
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
  \   'windows' : 'tools\\update-dll-mingw',
  \   'cygwin' : 'make -f make_cygwin.mak',
  \   'mac' : 'make -f make_mac.mak',
  \   'unix' : 'make -f make_unix.mak',
  \   },
  \ }

" Display {{{2
" Colorschemes {{{3
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'jpo/vim-railscasts-theme'
" Show indent level with space {{{3
NeoBundle 'Yggdroot/indentLine'
if has('conceal')
  let g:indentLine_char='¦'
  let g:indentLine_color_term=239
endif
" Customize status line {{{3
NeoBundle 'itchyny/lightline.vim'

" Utilities {{{2
" Substitute all {{{3
NeoBundle 'osyo-manga/vim-over'
nnoremap <silent> <Leader>m :OverCommandLine<CR>
" Grep {{{3
NeoBundle 'vim-scripts/grep.vim'
nnoremap <silent> <leader>f :Rgrep<CR>
let Grep_Default_Options = '-IR'
" VimShell {{{3
NeoBundle 'Shougo/vimshell.vim'
let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
let g:vimshell_prompt =  '$ '
nnoremap <silent> ,is :VimShell<CR>
nnoremap <silent> ,irb :VimShellInteractive irb<CR>
" Dictionary {{{3
NeoBundle  'itchyny/dictionary.vim'
vmap <Enter> <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)
" Close text Objects with surrounds {{{3
NeoBundle 'kana/vim-operator-user' " dependency
NeoBundle 'rhysd/vim-operator-surround'
map <silent>sa <Plug>(operator-surround-append)
map <silent>sd <Plug>(operator-surround-delete)
map <silent>sr <Plug>(operator-surround-replace)
" Incremental search {{{3
NeoBundle 'haya14busa/incsearch.vim'
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
" Highlight the selected word {{{3
NeoBundle 't9md/vim-quickhl'
nmap <Space>m <Plug>(quickhl-manual-this)
xmap <Space>m <Plug>(quickhl-manual-this)
nmap <Space>M <Plug>(quickhl-manual-reset)
xmap <Space>M <Plug>(quickhl-manual-reset)
" Explore files and directories {{{3
NeoBundle 'Shougo/vimfiler.vim'
let g:vimfiler_as_default_explorer=1
" Extended f, F key mapping {{{3
NeoBundle 'rhysd/clever-f.vim'
" Fuzzy file, buffer.. {{{3
NeoBundle 'kien/ctrlp.vim'
let g:ctrlp_map = '<C-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|swp|zip)$',
  \ }

" Automation {{{2
" Auto save {{{3
NeoBundle 'syui/wauto.vim'
let g:auto_write = 1
" Auto close parentheses {{{3
NeoBundle 'Townk/vim-autoclose'
" Quick run {{{3
NeoBundle 'thinca/vim-quickrun.git'
let g:quickhl_config = {'_': {'split': 'vertical'}}
nnoremap <leader>r :QuickRun<CR>
" Comment out quickly {{{3
NeoBundle 'scrooloose/nerdcommenter'
let NERDSpaceDelims=1
let NERDShutUp=1
nmap ,, <Plug>NERDCommenterToggle
vmap ,, <Plug>NERDCommenterToggle
" Easiy align {{{3
NeoBundle 'junegunn/vim-easy-align'

" Completion {{{2
" neocomplete {{{3
NeoBundle 'Shougo/neocomplete.vim'
" neosnippet {{{3
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'

" Language {{{2
" Ruby {{{3
NeoBundleLazy 'rails.vim'
NeoBundleLazy 'tpope/vim-rails'
NeoBundleLazy 'tpope/vim-rake'
NeoBundleLazy 'tpope/vim-projectionist'
NeoBundleLazy 'thoughtbot/vim-rspec'
NeoBundleLazy 'tpope/vim-endwise'
" Python {{{3
NeoBundleLazy 'davidhalter/jedi-vim'
" HTML {{{3
NeoBundleLazy 'lilydjwg/colorizer'
NeoBundleLazy 'nono/vim-handlebars'
NeoBundleLazy 'amirh/HTML-AutoCloseTag'
" Git {{{3
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'rhysd/committia.vim'
" Markdown {{{3
NeoBundleLazy 'mutewinter/vim-markdown'

" Reccomended {{{2
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'rstacruz/sparkup', {'rtp': 'vim/'}
NeoBundle 'L9'
NeoBundle 'FuzzyFinder'
NeoBundle 'unite.vim'
NeoBundle 'wincent/command-T.git'
let g:CommandTMaxHeight = 20
nmap <leader>b :CommandTBuffer<CR>
nmap <leader>t :CommandT<CR>
nmap <leader>T :CommandTFlush<CR>:CommandT<CR>
NeoBundle 'http://svn.macports.org/repository/macports/contrib/mpvim/'
NeoBundle 'https://bitbucket.org/ns9tks/vim-fuzzyfinder'

" End of initialization {{{2
filetype plugin indent on
call neobundle#end()
NeoBundleCheck


runtime! userautoload/*.vim

" Modelines
" vim: foldmethod=marker
" vim: foldcolumn=3
" vim: foldlevel=0
