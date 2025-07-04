autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit

# zsh customization
source $ZDOTDIR/.zshenv
source $ZDOTDIR/theme/minimal.zsh
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(/opt/homebrew/bin/brew shellenv)"
. $(brew --prefix asdf)/libexec/asdf.sh
eval "$(~/.local/bin/mise activate zsh)"

# Enabling menu selection
zstyle ':completion:*' menu select

bindkey -e
export LC_ALL=en_US.UTF-8

# zsh history {{{
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.

# Enable ^, see https://github.com/robbyrussell/oh-my-zsh/issues/449#issuecomment-6973326
setopt NO_NOMATCH
setopt AUTOCD

export WORDCHARS=''
export CLICOLOR=1
export BLOCK_SIZE=human-readable # https://www.gnu.org/software/coreutils/manual/html_node/Block-size.html
export HISTSIZE=10000000
export SAVEHIST=10000000
export HISTFILE=~/.zsh_history
# }}}

# aliases {{{
alias ll='exa -Flh --git'
alias l='exa -l'
alias la='ll -a'
alias lt='ll -T'
alias vim="nvim"
alias vi="nvim"
alias k="kubectl"
# }}}

BREWBINPATH="$(brew --prefix)/bin"

# auto complete {{{
complete -o nospace -C terraform terraform
complete -o nospace -C vault vault
source <(kubectl completion zsh)
# }}}

source <(fzf --zsh)

set -o vi

bindkey "^R" fzf-history-widget

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'm:{a-zA-Z}={A-Za-z} l:|=* r:|=*'
