# PATH {{{1
export PATH=/usr/local/bin:$PATH

# rbenv
export PATH="$HOME/.rbenv/shims:$PATH"
eval "$(rbenv init -)"

# Sublime
export PATH=/opt/local/lib:~/bin:$PATH
export EDITOR='sbl -w'

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Text Wrangler
alias tw='open -a /Applications/TextWrangler.app'

GNUTERM=x11

#補完関係　{{{1
#補完設定をロードして設定
autoload -U compinit
compinit

#補完候補のカラー表示
zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

#コマンドにsudoを付けてもきちんと補完出来るようにする。Ubuntuだと/etc/zsh/zshrcで設定されている。
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

#大文字・小文字を区別しないで補完出来るようにするが、大文字を入力した場合は区別する。
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

#補完候補を矢印キーなどで選択出来るようにする。'select=3'のように指定した場合は、補完候補が3個以上ある時に選択出来るようになる。
zstyle ':completion:*:default' menu 'select=3'

#先方予測機能
autoload predict-on
predict-on

#コマンドの間違いを修正
setopt correct

#補完候補を一覧表示
setopt auto_list

#TAB で順に補完候補を切り替える
setopt auto_menu

#補完候補一覧でファイルの種別をマーク表示
setopt list_types

#括弧を自動補完
setopt auto_param_keys
#履歴関係 {{{1
#コマンド履歴
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_all_dups #ignore duplication command history list
setopt hist_no_store        #historyコマンドは履歴に登録しない
setopt share_history        #share command history data
setopt hist_reduce_blanks   #余分な空白は詰めて記録

#履歴検索機能のショートカット設定
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end


#操作関係 {{{1
#Vimライクキーバインド
bindkey -v

#補完候補のメニュー選択で、矢印キーの代わりにhjklで移動出来るようにする。
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

#ディレクトリ名でcd
setopt auto_cd

#タブキーで移動したディレクトリを一覧
setopt auto_pushd

#カラー設定 {{{1
#プロンプトカラー設定
PROMPT='%n@%m%# '
RPROMPT='[%~]'
setopt transient_rprompt
SPROMPT="%e is correct? [n,y,a,e]: "

#lsコマンド結果のカラー表示
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'


#エイリアス設定 {{{1

alias ls="ls -G"
alias gls="gls --color"

#Alias
alias gcc="gcc -Wall -o"
alias g++="g++ -Wall"
alias vi="vim"

alias ls="ls -G -w"
alias la="ls -a"
alias lf="ls -F"
alias ll="ls -l"

alias du="du -h"
alias df="df -h"

alias su="su -l"

alias rake="noglob rake"

 #その他 {{{1
#言語設定
export LANG=ja_JP.UTF-8

#" vim: foldmethod=marker
#" vim: foldcolumn=3
#" vim: foldlevel=0
