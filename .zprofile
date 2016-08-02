#
# Browser
#
if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

#
# Editors
#
export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'

#
# Env
#
export SHELL="$(which zsh)"
export HOMEBREW_BREWFILE=~/.brewfile

#
# Language
#
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

# Others
export XDG_CONFIG_HOME=~/.config

#
# Paths
#
# Ensure path arrays do not contain duplicates
typeset -gU cdpath fpath mailpath path

cdpath=(
  ..
  $HOME
  $HOME/Repos
  $cdpath
)
path=(
  /usr/local/{bin,sbin}
  $path
)
if [[ -r $HOME/.zprofile_local ]]; then
  source $HOME/.zprofile_local
fi
# if [[ -r $HOME/PATH ]]; then
#   eval "env_path=(`cat $HOME/PATH`)"
#   path=("${path[@]}" "${env_path[@]}")
# fi

#
# Less
#
# Default Less options
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi


#
# Temporary Files
#
if [[ ! -d "$TMPDIR" ]]; then
  export TMPDIR="/tmp/$USER"
  mkdir -p -m 700 "$TMPDIR"
fi

TMPPREFIX="${TMPDIR%/}/zsh"
if [[ ! -d "$TMPPREFIX" ]]; then
  mkdir -p "$TMPPREFIX"
fi
