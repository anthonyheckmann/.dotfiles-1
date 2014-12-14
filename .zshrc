# 補完関係　{{{1
# 補完設定をロードして設定
autoload -U compinit
compinit

# 補完候補のカラー表示
zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

# コマンドにsudoを付けてもきちんと補完出来るようにする。Ubuntuだと/etc/zsh/zshrcで設定されている。
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# 大文字・小文字を区別しないで補完出来るようにするが、大文字を入力した場合は区別する。
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# 補完候補を矢印キーなどで選択出来るようにする。'select=3'のように指定した場合は、補完候補が3個以上ある時に選択出来るようになる。
zstyle ':completion:*:default' menu 'select=3'

# 先方予測機能
autoload predict-on
predict-on

# コマンドの間違いを修正
setopt correct

# 補完後、カーソルを末尾に
setopt always_to_end

# 補完候補を一覧表示
setopt auto_list

# TAB で順に補完候補を切り替える
setopt auto_menu

# 補完候補一覧でファイルの種別をマーク表示
setopt list_types

# 括弧を自動補完
setopt auto_param_keys

# ディレクトリ名末尾の/補完
setopt auto_param_slash

# ファイル名展開でディレクトリとマッチした場合の/補完
setopt mark_dirs

# 語の途中でもカーソル位置で補完
setopt complete_in_word

# カーソル位置は保持したままファイル名一覧を順次その場で表示
setopt always_last_prompt

# 明確なドットの指定なしで.から始まるファイルをマッチ
setopt globdots
# 履歴関係 {{{1
# コマンド履歴
HISTFILE=~/.zsh_history
HISTSIZE=20000
SAVEHIST=20000
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_no_store
setopt share_history
setopt hist_reduce_blanks

# 履歴検索機能のショートカット設定
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# 操作関係 {{{1
# Vimライクキーバインド
bindkey -v

# 補完候補のメニュー選択で、矢印キーの代わりにhjklで移動出来るようにする。
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# ディレクトリ名でcd
setopt auto_cd

#タブキーで移動したディレクトリを一覧
setopt auto_pushd

# カラー設定 {{{1
export TERM=xterm-256color
# プロンプトカラー設定
PROMPT='%n@%m%(!.#.$) '
RPROMPT='[%~]'
setopt transient_rprompt
SPROMPT="%r is correct? [n,y,a,e]: "

# lsコマンド結果のカラー表示
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# エイリアス設定 {{{1
# Commands
alias gco="gcc -Wall -o"
alias gpo="g++ -Wall -o"

alias df="df -h"
alias lss="ls -alhGF"

alias cb="cd-bookmark"

# Octopress
alias brake="noglob bundle exec rake"
compdef -d rake

# Dotfiles
alias vimrc="vim $HOME/.vimrc"
alias zshrc="vim $HOME/.zshrc"

# その他 {{{1
# cd-bookmark
fpath=($HOME/.zsh/functions/cd-bookmark(N-/) $fpath)
autoload -Uz cd-bookmark

# peco - cd-bookrmark
function cbp() {
	cb | peco | awk -F"|" '{ print $2 }' | xargs open
}

# peco - history filter
function ph() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}

# peco - kill process
function pkp() {
    ps -ef | peco | awk '{ print $2 }' | xargs kill
    zle clear-screen
}

# peco - search file and open with vim
function gim() {
	vim `git ls-files | peco`
	# vim `find . -name "*" | peco`
}

# Auto rbenv rehash
function gem(){
  $HOME/.rbenv/shims/gem $*
  if [ "$1" = "install" ] || [ "$1" = "i" ] || [ "$1" = "uninstall" ] || [ "$1" = "uni" ]
  then
    rbenv rehash
  fi
}

function bundle(){
  $HOME/.rbenv/shims/bundle $*
  if [ "$1" = "install" ] || [ "$1" = "update" ]
  then
    rbenv rehash
  fi
 }

# Blank enter
function blank_enter {
    if [[ -n "$BUFFER" ]]; then
        builtin zle .accept-line
        return 0
    fi
    if [ "$WIDGET" != "$LASTWIDGET" ]; then
        BLANK_ENTER_COUNT=0
    fi
    case $[BLANK_ENTER_COUNT++] in
        0)
            BUFFER=" ls -ahlFG"
            ;;
        1)
            if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
                BUFFER=" git status -sb"
            elif [[ -d .svn ]]; then
                BUFFER=" svn status"
            fi
            ;;
        *)
            unset BLANK_ENTER_COUNT
            ;;
    esac
    builtin zle .accept-line
}
zle -N blank_enter
bindkey '^m' blank_enter

# Edit command line with editor
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^XE' edit-command-line

#" vim: foldmethod=marker
#" vim: foldcolumn=3
#" vim: foldlevel=0