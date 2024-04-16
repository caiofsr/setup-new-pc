#!/bin/bash

brew_install() {
  echo "Installing Homebrew"

  curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

  brew install gcc
}

install_depencies() {
  echo "Updating apt"

  sudo apt update

  sudo apt upgrade -y

  echo "Installing dependencies"

  sudo apt install -y wget curl zsh git
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

  sudo chsh -s $(which zsh)
}

install_depencies

install_oh_my_zsh

clone_repo

brew_install

delete_repo

echo "Setup done successfully"
