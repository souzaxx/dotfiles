# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="agnoster"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(brew gem git git-extras heroku node npm powify rbenv rails redis-cli safe-paste tmux tmuxinator vagrant docker zeus)


# Use English as the language
LANG='en_US.UTF-8'
LC_CTYPE='en_US.UTF-8'
export LANG
export LC_CTYPE

source $ZSH/oh-my-zsh.sh
source $HOME/code/dotfiles/promptline.sh

# Customize to your needs...

# export PATH=/usr/local/bin:/usr/local/sbin:$PATH
# PATH=/usr/local/bin:/usr/local/sbin:/usr/local/share/npm/bin:$PATH
PATH=/Applications/Postgres.app/Contents/MacOS/bin:$PATH

# fpath=(/usr/local/share/zsh $fpath)
# fpath=($HOMEBREW_ROOT/share/zsh/site-functions $fpath)
fpath=($HOMEBREW_ROOT/share/zsh-completions $fpath)

# boxen paths and stuff
[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh

# zsh highlight
source $HOMEBREW_ROOT/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# tmuxinator
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

# Use MacVim
# alias vim="/usr/local/bin/mvim -v"
# alias vimdiff="/usr/local/bin/mvim -v mvimdiff"

export EDITOR=vim
export SHELL=$BOXEN_HOME/bin/zsh
export DOCKER_HOST=localhost

# Bash aliases
alias l="ls -hG"
alias ll="ls -lhG"
alias la="ls -alhG"
alias psg="ps aux | grep"
alias k9="kill -9"
alias json='python -mjson.tool'
# alias tmux="TERM=screen-256color-bce tmux"

# Ruby and Rails aliases
alias be="bundle exec"
alias bi="bundle check || bundle install"
alias biv="bundle install --verbose"
alias bu="bundle update"
alias bo="bundle open"

# python webserver
alias server="python -m SimpleHTTPServer"

# Larger bash history (allow 32³ entries; default is 500)
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL=ignoredups

# Make some commands not show up in history
export HISTIGNORE="l:ll:la:ls:ls *:cd:cd ..:cd -:pwd;exit:date:* --help"

# Toggle OS X hidden files
alias hidden_files="defaults write com.apple.finder AppleShowAllFiles"

# fix Open With menu
alias fix_open_with='/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -kill -r -domain local -domain user && killall Finder'

# export PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

hitch() {
  command hitch "$@"
  if [[ -s "$HOME/.hitch_export_authors" ]] ; then source "$HOME/.hitch_export_authors" ; fi
}
alias unhitch='hitch -u'

gifify() {
  if [[ -n "$1" ]]; then
    GIF="${1%.*}.gif"
    if [[ $2 == '--ugly' ]]; then
      ffmpeg -i $1 -pix_fmt rgb24 -r 10 -f gif - | gifsicle --optimize=3 --delay=3 > $GIF
    else
      ffmpeg -i $1 -r 10 -vcodec png out-static-%05d.png
      time convert -verbose +dither -layers Optimize out-static*.png  GIF:- | gifsicle --colors 128 --delay=5 --loop --optimize=3 --multifile - > $GIF
      rm out-static*.png
    fi
  else
    echo "proper usage: gifify --ugly <input_movie.mov>. You DO need to include extension."
  fi
}
