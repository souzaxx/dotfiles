# source local config
[[ -f $HOME/.zshlocal ]] && source $HOME/.zshlocal

# goenv + Go {{{
export GOPATH=$HOME/code/go
export GOENV_SHELL=zsh

export PATH="$GOPATH/bin:$PATH"
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

export EDITOR=nvim