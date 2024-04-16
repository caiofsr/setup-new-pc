#!/bin/bash

brew_install() {
  echo "Installing Homebrew"

  curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

  brew install gcc
}

install_depencies() {
  echo "Installing dependencies"

  sudo apt install -y wget curl zsh
}

install_depencies

brew_install
