#!/bin/bash -e

echo
echo '# Setup ~/my'
if ! [ -e ~/my ]
then
  git clone https://github.com/dtinth/my.git ~/my
  echo "  * ~/my is set up."
else
  echo "  * Already done."
fi

if [ "$(lsb_release -cs)" = "stretch" ]
then
  echo
  echo '# Debian stretch detected'

  echo
  echo '# Fish shell'
  if ! (fish --version | grep 'version 3')
  then
    echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/3/Debian_9.0/ /' | sudo tee /etc/apt/sources.list.d/shells:fish:release:3.list
    curl -fsSL https://download.opensuse.org/repositories/shells:fish:release:3/Debian_9.0/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/shells:fish:release:3.gpg > /dev/null
    sudo apt update -y
    sudo apt install fish -y
  else
    echo "  * Already installed"
  fi
fi

if [ "$(whoami)" = "codespace" ]
then
  sudo chsh -s /usr/bin/fish codespace
fi

echo
echo '# Setup oh-my-fish'
if (fish --version | grep 'version 3')
then
  if ! [ -e ~/.local/share/omf ]
  then
    curl -L https://get.oh-my.fish > /tmp/omf-installer
    fish /tmp/omf-installer --path=~/.local/share/omf --config=~/my/omf
  else
    echo "  * Already done."
  fi
else
  echo "  * fish is not available."
fi

echo
echo '# Setup fzf'
if ! [ -e ~/.fzf ]
then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  yes | ~/.fzf/install
else
  echo "  * Already have fzf"
fi