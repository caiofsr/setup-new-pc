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

  git clone https://github.com/spaceship-prompt/spaceship-prompt.git "~/.oh-my-zsh/themes/spaceship-prompt" --depth=1

  ln -s "~/.oh-my-zsh/themes/spaceship-prompt/spaceship.zsh-theme" "~/.oh-my-zsh/themes/spaceship.zsh-theme"

  curl -fsSL https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh | bash

  cp ~/.setup-pc/zsh/.zshrc ~/.zshrc

  zsh
}

install_asdf() {
  echo "Installing asdf"

  brew install asdf

  source ~/.zshrc

  echo "Installing NodeJS with asdf"
  asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
  asdf install nodejs latest

  echo "Installing Go with asdf"
  asdf plugin add golang https://github.com/asdf-community/asdf-golang.git
  asdf install golang latest

  echo "Installing bun with asdf"
  asdf plugin add bun
  asdf install bun latest
}

post_install() {
  echo "Running post install commands"

  brew cleanup && rm -f $ZSH_COMPDUMP && omz reload

  cd ~ && rm -rf .setup-pc
}

install_depencies

brew_install

clone_repo

install_oh_my_zsh

install_asdf

post_install

echo "Setup done successfully"
