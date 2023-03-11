#!/bin/bash

# install zsh & zi
apt install zsh
sh -c "$(curl -fsSL git.io/get-zi)" -- -a annex

# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo '# Set PATH, MANPATH, etc., for Homebrew.' >> $HOME/.profile
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $HOME/.profile
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $HOME/.zshrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

chsh -s /bin/zsh

brew install z
brew install jandedobbeleer/oh-my-posh/oh-my-posh
brew install gh


HOMEBREW=/home/linuxbrew/.linuxbrew

cat .ref.zshrc >> $HOME/.zhrc
cat .ref.zshenv >> $HOME/.zshenv


echo ". /home/linuxbrew/.linuxbrew/etc/profile.d/z.sh" >> $HOME/.zshrc

exec zsh &&
apt update
apt install npm

# micro editor with plugins
brew install micro

micro -plugin install nordcolors
micro -plugin install autofmt
micro -plugin install misspell
micro -plugin install filemanager

## add this to your .zshrc for zi

brew install python3

echo 'path+=/home/linuxbrew/.linuxbrew/opt/python@3.11/libexec/bin' >> $HOME/.zshenv

echo "source ~/.zi/bin/zi.zsh" >> $HOME/.zshrc

eval "$(oh-my-posh init zsh --config $BREWHOME/opt/oh-my-posh/themes/arno-pure.omp.json)"

curl -sSL https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh > miniconda-install.sh

/bin/bash miniconda-install.sh -b

