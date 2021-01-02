# source local config
[[ -f $HOME/.zshlocal ]] && source $HOME/.zshlocal

# goenv + Go {{{
export GOPATH=$HOME/code/go
export GOENV_SHELL=zsh

export PATH="$HOME/.goenv/shims:$GOPATH/bin:$PATH"
# source "$HOMEBREW_CELLAR/goenv/1.23.3/completions/goenv.zsh"
goenv() {
  local command
  command="$1"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  rehash|shell)
    eval "$(goenv "sh-$command" "$@")";;
  *)
    command goenv "$command" "$@";;
  esac
}
# }}}

# pyenv + Python {{{
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PYENV_ROOT/shims:$PATH"

# command pyenv rehash 2>/dev/null
pyenv() {
  local command
  command="${1:-}"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  rehash|shell)
    eval "$(pyenv "sh-$command" "$@")";;
  *)
    command pyenv "$command" "$@";;
  esac
}
# }}}

# fzf + fzf-tmux {{{
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2>/dev/null'
export FZF_DEFAULT_OPTS="--height 40% --inline-info"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat -p --color always -r :50 {}'"
export FZF_CTRL_R_OPTS='--exact'
export FZF_ALT_C_OPTS="--preview 'exa -TF {} | head -50'"
export FZF_TMUX="$TMUX"
# }}}

# misc
export EDITOR=nvim
# function terraform_ws {
#      local statc="%{\e[0;35m%}" # assume clean

#      if [ -d .terraform ]; then
#       workspace=$(terraform workspace show 2> /dev/null) || return
#       printf '%b' "$statc$workspace%{\e[0m%}"
#      fi
# }

# MNML_RPROMPT=( $MNML_RPROMPT terraform_ws )

# vim:foldmethod=marker:foldlevel=0:nomodeline:


