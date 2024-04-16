#!/bin/bash

brew_install() {
  echo -e "###############\n${PURPLE} Installing Homebrew\n###############"

  curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

  (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /home/caio/.bashrc
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

  brew install gcc
}

install_depencies() {
  echo -e "###############\n${PURPLE} Update apt\n###############"

  sudo apt update

  sudo apt upgrade -y

  echo -e "###############\n${PURPLE} Installing dependencies\n###############"

  sudo apt install -y wget curl zsh git build-essential
}

clone_repo() {
  echo -e "###############\n${PURPLE} Cloning repo\n###############"

  git clone https://github.com/caiofsr/setup-new-pc.git .setup-pc

  cd .setup-pc
}

install_oh_my_zsh() {
  echo -e "###############\n${PURPLE} Installing oh my zsh\n###############"

  curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | bash

  sudo chsh -s /bin/zsh

  echo -e "###############\n${PURPLE} Cloning spaceship-theme\n###############"

  git clone https://github.com/spaceship-prompt/spaceship-prompt.git "~/.oh-my-zsh/themes/spaceship-prompt" --depth=1

  ln -s "~/.oh-my-zsh/themes/spaceship-prompt/spaceship.zsh-theme" "~/.oh-my-zsh/themes/spaceship.zsh-theme"

  curl -fsSL https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh | bash

  cp ~/.setup-pc/zsh/.zshrc ~/.zshrc

  zsh
}

install_asdf() {
  echo -e "###############\n${PURPLE} Installing asdf\n###############"

  brew install asdf

  source ~/.zshrc

  echo -e "###############\n${PURPLE} Installing NodeJS with asdf\n###############"
  asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
  asdf install nodejs latest

  echo -e "###############\n${PURPLE} Installing Go with asdf\n###############"
  asdf plugin add golang https://github.com/asdf-community/asdf-golang.git
  asdf install golang latest

  echo -e "###############\n${PURPLE} Installing bun with asdf\n###############"
  asdf plugin add bun
  asdf install bun latest
}

post_install() {
  echo -e "###############\n${PURPLE} Running post install commands\n###############"

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
