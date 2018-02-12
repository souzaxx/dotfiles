# Check if zplug is installed
# if [[ ! -d ~/.zplug ]]; then
#   git clone https://github.com/zplug/zplug ~/.zplug
# fi

# Check if ~/.dotfiles is cloned
# if [[ ! -d ~/.dotfiles ]]; then
#   git clone https://github.com/danilopopeye/dotfiles ~/.dotfiles
# fi

source ~/.zplug/init.zsh

# commands
zplug "junegunn/fzf", as:command, use:'bin/fzf-tmux'
zplug "junegunn/fzf-bin", from:gh-r, as:command, rename-to:fzf
zplug "stedolan/jq", from:gh-r, as:command, rename-to:jq
# zplug "yudai/sshh", as:command
zplug "b4b4r07/httpstat", as:command, use:'(*).sh', rename-to:'$1'
zplug "BurntSushi/ripgrep", from:gh-r, as:command, rename-to:rg
zplug "BurntSushi/xsv", from:gh-r, as:command
zplug "bcicen/ctop", from:gh-r, as:command, rename-to:ctop
zplug "asciimoo/wuzz", from:gh-r, as:command, rename-to:wuzz
zplug "awslabs/aws-sam-local", from:gh-r, as:command, rename-to:sam

# XXX: depends of issue #298 to work
# zplug "ogham/exa", from:gh-r, as:command, rename-to:exa

# helpers
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/httpie", from:oh-my-zsh
zplug "plugins/ssh-agent", from:oh-my-zsh
zplug "plugins/safe-paste", from:oh-my-zsh
zplug "greymd/tmux-xpanes"

zplug "danilopopeye/dotfiles"
zplug "danilopopeye/dotfiles", as:command, use:"bin/*"

zplug "zsh-users/zsh-completions"
# zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zdharma/fast-syntax-highlighting"

# Then, source plugins and add commands to $PATH
zplug load

# rbenv & pyenv & nodenv & goenv
eval "$(rbenv init -)"
eval "$(pyenv init -)"
eval "$(nodenv init -)"
eval "$(goenv init -)"

# rust toolkit
export PATH=$PATH:~/.cargo/bin

# alias ll="ls -lh"
alias ll="exa -bghHl --git"
alias la="ll -a"
alias lt="ll -T"
alias vim=nvim
alias tf=terraform

# local AWS development helpers
alias sns='dotenv aws --endpoint-url http://localhost:4100 sns'
alias sqs='dotenv aws --endpoint-url http://localhost:4100 sqs'
alias dynamodb='dotenv aws --endpoint-url http://localhost:8889 dynamodb'

export LESS=-r
export EDITOR=nvim
export LC_ALL="en_US.UTF-8"
export PATH=$HOME/.npm-global/bin:./node_modules/.bin:$PATH
export DOCKER_HOST="tcp://127.0.0.1:2376"

export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob \!.git 2>/dev/null'
export FZF_DEFAULT_OPTS="--height 40% --inline-info"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'head -50 {}'"
export FZF_CTRL_R_OPTS='--exact'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
export FZF_TMUX="$TMUX"

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

# Enable ^, see https://github.com/robbyrussell/oh-my-zsh/issues/449#issuecomment-6973326
setopt NO_NOMATCH
setopt AUTOCD

export WORDCHARS=''
export CLICOLOR=1
export BLOCK_SIZE=human-readable # https://www.gnu.org/software/coreutils/manual/html_node/Block-size.html
export HISTSIZE=11000
export SAVEHIST=10000
export HISTFILE=~/.zsh_history
