#!/bin/bash

_check_dependencies(){
 if ! command -v brew > /dev/null; then
   read -p "Dependency not met, you don't have homebrew installed. Do you want to install it? (y/n) " prompt
   if [[ $prompt == "y" || $prompt == "Y" || $prompt == "yes" || $prompt == "Yes" ]]; then
     echo "Installing Homebrew..."
     bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
     eval "$(/opt/homebrew/bin/brew shellenv)"
   else
     echo "[ERROR] Dependency not met: homebrew"
     exit 1
   fi
 fi
}

_install_tools(){
  asdf_packages=(
    'terraform'
    'vault'
    'fzf'
    'golang'
    'helm'
    'jsonnet'
    'kubectl'
    'kubectx'
    'python'
    "jq"
    'yq'
    'neovim'
    "awscli"
    "terraform-ls"
    "minikube"
  )
  brew_packages=(
    "asdf"
    "coreutils"
    "curl"
    "iterm2" 
    "git"
    "icdiff"
    "rg"
    "zsh"
    "gpg"
    "tmux"
    "qemu"
    "docker"
    "docker-compose"
    "go"
    "rectangle"
    "stats"
    "dozer"
    "bat"
  )

  if [[ $OSTYPE == 'darwin'* ]]; then
    eval brew install "${brew_packages[*]}"

    . $(brew --prefix asdf)/libexec/asdf.sh
  fi

  for index in "${asdf_packages[@]}"; do
    asdf plugin add $index
    asdf install $index latest
    asdf global $index $(asdf latest $index)
  done
}

_config_zsh(){
  ln -fs $PWD/zsh/zshrc  ~/.zshrc
  ln -fs $PWD/zsh/zshenv ~/.zshenv
  if [[ ! -f $HOME/.zsh/theme/minimal.zsh ]]; then
    curl -flo $HOME/.zsh/theme/minimal.zsh --create-dirs https://raw.githubusercontent.com/subnixr/minimal/master/minimal.zsh
  fi
  if [[ ! -f $HOME/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh ]]; then
    mkdir -p $HOME/.zsh/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.zsh/plugins/zsh-syntax-highlighting
  fi
}

_config_tmux(){
  ln -fs $PWD/tmux/tmux.conf 	 ~/.tmux.conf
  ln -fs $PWD/tmux/tmuxline.conf ~/.tmuxline.conf
  if [[ ! -f $HOME/.tmux/plugins/tpm/tpm ]]; then
    mkdir -p ~/.tmux/plugins && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  fi
  tmux new-session -A -s myprogramsession \
    send -t myprogramsession "nohup $HOME/.tmux/plugins/tpm/bindings/install_plugins &>/dev/null &" ENTER \
    detach -s myprogramsession && sleep 1 && pkill tmux
}

_config_vim(){
  if [[ ! -f $HOME/.local/share/nvim/site/autoload/plug.vim ]]; then
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
          https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  fi
  mkdir -p ~/.config/nvim
  ln -fs $PWD/vim/nvim.vim ~/.config/nvim/init.vim
  vim -E -s -u "~/.config/nvim/init.vim" +PlugInstall +qall
}

_config_git(){
  ln -fs $PWD/git/gitconfig ~/.gitconfig
}

_install_font(){
  if [[ ! -f $HOME/Library/Fonts/ProFont\ For\ Powerline.ttf ]]; then
    curl -Lsfo ~/Library/Fonts/ProFont\ For\ Powerline.ttf 'https://github.com/powerline/fonts/raw/master/ProFont/ProFont%20For%20Powerline.ttf'
  fi
}

main() {
#   _check_dependencies
#   _install_tools
#   _config_zsh
#   _config_tmux
#   _config_vim
#   _config_git
  _install_font
}

main
