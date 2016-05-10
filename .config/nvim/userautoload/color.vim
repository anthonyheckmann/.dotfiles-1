" Colorscheme
set background=dark
colorscheme railscasts

" Terminal
if has('nvim')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
else
  if &term =~ "xterm-256color" || "screen-256color"
    set t_Co=256
    set t_Sf=[3%dm
    set t_Sb=[4%dm
  elseif &term =~ "xterm-color"
    set t_Co=88
    set t_Sf=[3%dm
    set t_Sb=[4%dm
  endif
endif

" Highlight
syntax enable
hi PmenuSel cterm=reverse ctermfg=33 ctermbg=222 gui=reverse guifg=#3399ff guibg=#f0e68c
hi CursorLine cterm=underline term=underline
