#!/bin/bash
set -x

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
   'consul|packer|waypoint|terraform|vault|boundary::https://github.com/Banno/asdf-hashicorp.git'
   'fzf::https://github.com/kompiro/asdf-fzf.git'
   'golang::https://github.com/kennyp/asdf-golang.git'
   'helm::https://github.com/Antiarchitect/asdf-helm.git'
   'java::https://github.com/halcyon/asdf-java.git'
   'jq::https://github.com/focused-labs/asdf-jq.git'
   'jsonnet::https://github.com/Banno/asdf-jsonnet.git'
   'kubectl::https://github.com/Banno/asdf-kubectl.git'
   'kubectx::'
   'python::'
   'tmux::https://github.com/aphecetche/asdf-tmux.git'
   'yq::https://github.com/sudermanjr/asdf-yq.git'
 )
 brew_packages=(
   "asdf"
   "coreutils"
   "curl"
   "git"
   "icdiff"
   "rg"
   "zsh"
   "awscli"
   "gpg"
   "neovim"
   "hashicorp/tap/terraform-ls"
 )

 brew install $brew_packages
 asdf_config="$(brew --prefix asdf)/asdf.sh"

 for index in "${asdf_packages[@]}"; do
   KEY="${index%%::*}"
   VALUE="${index##*::}"

   asdf plugin-add ${KEY//|/ } $VALUE
   asdf install ${KEY//|/ } latest
 done
}


_config_zsh(){
  # Copy zsh config
  cp zsh/zshenv $HOME/.zshenv
  cp zsh/zshrc $HOME/.zshrc
  mkdir -p $HOME/.zsh/theme $HOME/.zsh/plugins/zsh-syntax-highlighting
  cd $HOME/.zsh/theme
  curl -sS https://raw.githubusercontent.com/subnixr/minimal/master/minimal.zsh -O minimal.zsh 
  cd -
  cd $HOME/.zsh/plugins
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
  cd -
}

_config_tmux(){
  mkdir -p ~/.tmux/plugins
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  # Copy tmux config
  cp tmux/tmux.conf $HOME/.tmux.conf
  cp tmux/tmuxline.conf $HOME/.tmuxline.conf
}

_config_vim(){
  mkdir -p ~/.config/nvim
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  cp vim/nvim.vim $HOME/.config/nvim/init.vim
}

main() {
  _check_dependencies
  _install_tools
  _config_zsh
  _config_tmux
  _config_vim
}
main