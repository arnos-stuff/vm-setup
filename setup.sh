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

cat .ref.zshrc >> $HOME/.zhrc
cat .ref.zshenv >> $HOME/.zshenv


echo ". /home/linuxbrew/.linuxbrew/etc/profile.d/z.sh" >> $HOME/.zshrc

exec zsh &&
apt update
apt install npm

# poetry
curl -sSL https://install.python-poetry.org | python3 -

# micro editor with plugins
brew install micro

micro -plugin install nordcolors
micro -plugin install autofmt
micro -plugin install misspell
micro -plugin install filemanager

## add this to your .zshrc for zi

echo "source ~/.zi/bin/zi.zsh" >> $HOME/.zshrc

## eval "$(oh-my-posh init zsh --config ~/.oh-my-posh/themes/arno-pure.omp.json)"

