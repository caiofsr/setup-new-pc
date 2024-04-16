#!/bin/bash

brew_install() {
  echo "Installing Homebrew"

  curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

  (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /home/caio/.bashrc
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

  brew install gcc

  brew cleanup && rm -f $ZSH_COMPDUMP && omz reload
}

install_depencies() {
  echo "Updating apt"

  sudo apt update

  sudo apt upgrade -y

  echo "Installing dependencies"

  sudo apt install -y wget curl zsh git build-essential
}

clone_repo() {
  echo "Cloning repo"

  git clone https://github.com/caiofsr/setup-new-pc.git .setup-pc

  cd .setup-pc
}

delete_repo() {
  echo "Deleting repo"

  cd ~ && rm -rf .setup-pc
}

install_oh_my_zsh() {
  echo "Installing oh-my-zsh"

  curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | bash

  sudo chsh -s /bin/zsh

  git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1

  ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

  curl -fsSL https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh | bash

  cp ./zsh/.zshrc ~/.zshrc
}

install_depencies

install_oh_my_zsh

clone_repo

brew_install

delete_repo

echo "Setup done successfully"
