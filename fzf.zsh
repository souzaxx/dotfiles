local FZF=/usr/local/opt/fzf/shell

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$FZF/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "$FZF/key-bindings.zsh"

