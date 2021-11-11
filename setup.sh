#!/bin/bash

_check_dependencies(){
 if ! command -v brew > /dev/null; then
   read -p "[INFO] Dependency not met, you don't have homebrew installed. Install? (y/n) " prompt
   if [[ $prompt == "y" || $prompt == "Y" || $prompt == "yes" || $prompt == "Yes" ]]; then
     echo "[INFO] Installing Homebrew..."
     /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
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
   'java'
   'jsonnet'
   'kubectl'
   'kubectx'
   'python'
   'yq'
   'neovim'
 )
 brew_packages=(
   "jq"
   "asdf"
   "coreutils"
   "curl"
   "git"
   "icdiff"
   "rg"
   "zsh"
   "awscli"
   "gpg"
   "hashicorp/tap/terraform-ls"
   "tmux"
   "bat"
   "go"
 )

 eval brew install "${brew_packages[*]}"
 brew install --cask rectangle

 . $(brew --prefix asdf)/asdf.sh

 for index in "${asdf_packages[@]}"; do
   asdf plugin add $index
   asdf install $index latest
   asdf global $index $(asdf latest $index)
 done
}

_config_zsh(){
  cp zsh/zshenv $HOME/.zshenv
  cp zsh/zshrc $HOME/.zshrc
  if [[ ! -f $HOME/.zsh/theme/minimal.zsh ]]; then
    curl -flo /Users/ldesouza/.zsh/theme/minimal.zsh --create-dirs https://raw.githubusercontent.com/subnixr/minimal/master/minimal.zsh
  fi
  if [[ ! -f $HOME/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh ]]; then
    mkdir -p $HOME/.zsh/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.zsh/plugins/zsh-syntax-highlighting
  fi
}

_config_tmux(){
  if [[ ! -f $HOME/.tmux/plugins/tpm/tpm ]]; then
    mkdir -p ~/.tmux/plugins && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  fi
  cp tmux/tmux.conf $HOME/.tmux.conf
  cp tmux/tmuxline.conf $HOME/.tmuxline.conf
}

_config_vim(){
  if [[ ! -f $HOME/.local/share/nvim/site/autoload/plug.vim ]]; then
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
          https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  fi
  mkdir -p ~/.config/nvim && cp vim/nvim.vim $HOME/.config/nvim/init.vim
}

main() {
  _check_dependencies
  _install_tools
  _config_zsh
  _config_tmux
  _config_vim
}

main
