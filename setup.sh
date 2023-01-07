#!/bin/bash

# Define a function which rename a `target` file to `target.backup` if the file
# exists and if it's a 'real' file, ie not a symlink
backup_files() {
  declare -a arr=("${@}")
  declare -i len=${#arr[@]}
  # Show passed array
  for ((n = 0; n < len; n++)); do
    target=${arr[$n]}
    if [ -e "$target" ]; then
      if [ ! -L "$target" ]; then
        mv "$target" "$target.backup"
        echo "-----> Moved your old $target config file to $target.backup"
      fi
    fi
  done
}

copy_files() {
  declare -a arr=("${@}")
  declare -i len=${#arr[@]}
  # Show passed array
  for ((n = 0; n < len; n++)); do
    file=$(echo ${arr[$n]} | cut -d "/" -f 2)
    echo "-----> Copying ${arr[$n]} config file to $HOME/.${file}"
    cp -v "${arr[$n]}" "$HOME/.${file}"
  done
}

_check_dependencies(){
 if ! command -v brew > /dev/null; then
   read -p "Dependency not met, you don't have homebrew installed. Install? (y/n) " prompt
   if [[ $prompt == "y" || $prompt == "Y" || $prompt == "yes" || $prompt == "Yes" ]]; then
     echo "Installing Homebrew..."
     /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
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
   "bat"
 )
 brew_packages=(
   "asdf"
   "coreutils"
   "curl"
   "git"
   "icdiff"
   "rg"
   "zsh"
   "gpg"
   "tmux"
   "hyperkit"
   "docker"
   "docker-compose"
   "go"
   "rectangle"
   "stats"
   "dozer"
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
  backup_files $HOME/.zshenv $HOME/.zshrc
  copy_files zsh/zshenv zsh/zshrc
  if [[ ! -f $HOME/.zsh/theme/minimal.zsh ]]; then
    curl -flo $HOME/.zsh/theme/minimal.zsh --create-dirs https://raw.githubusercontent.com/subnixr/minimal/master/minimal.zsh
  fi
  if [[ ! -f $HOME/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh ]]; then
    mkdir -p $HOME/.zsh/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.zsh/plugins/zsh-syntax-highlighting
  fi
}

_config_tmux(){
  backup_files $HOME/.tmux.conf $HOME/.tmuxline.conf
  copy_files tmux/tmux.conf tmux/tmuxline.conf
  if [[ ! -f $HOME/.tmux/plugins/tpm/tpm ]]; then
    mkdir -p ~/.tmux/plugins && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  fi
  tmux new-session -A -s myprogramsession \;
    send -t myprogramsession "nohup $HOME/.tmux/plugins/tpm/bindings/install_plugins &>/dev/null &" ENTER \;
    detach -s myprogramsession && sleep 1 && pkill tmux
}

_config_vim(){
  if [[ ! -f $HOME/.local/share/nvim/site/autoload/plug.vim ]]; then
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
          https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  fi
  mkdir -p ~/.config/nvim && cp vim/nvim.vim $HOME/.config/nvim/init.vim
}

_config_git(){
  backup_files $HOME/.gitconfig $HOME/.gitmodules
  copy_files git/gitconfig git/gitmodules
}

main() {
  _check_dependencies
  _install_tools
  _config_zsh
  _config_tmux
  _config_vim
  _config_git
}

main
