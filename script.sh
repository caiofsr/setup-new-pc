#!/bin/bash

brew_install() {
  echo "Installing Homebrew"

  curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

  (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /home/caio/.bashrc
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

  brew install gcc
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

install_oh_my_zsh() {
  echo "Installing oh-my-zsh"

  curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | bash

  sudo chsh -s /bin/zsh

  git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1

  ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

  curl -fsSL https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh | bash

  cp ./zsh/.zshrc ~/.zshrc
}

post_install() {
  zsh

  brew cleanup && rm -f $ZSH_COMPDUMP && omz reload

  cd ~ && rm -rf .setup-pc
}

install_depencies

install_oh_my_zsh

clone_repo

brew_install

post_install

echo "Setup done successfully"
