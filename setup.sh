#!/bin/bash
apt upgrade -y
apt install vim -y
apt install apt-utils -y
apt install curl git gcc -y
apt update -y

apt install build-essentials -y
apt install ruby -y

# use your creds
git config --global user.email "bcda0276@gmail.com"
git config --global user.name "arnos-stuff"

echo "#! /bin/bash\n\nshopt \$*\n" > /usr/local/bin/shopt
chmod +x /usr/local/bin/shopt
ln -s /usr/local/bin/shopt /usr/bin/shopt
echo "alias shopt='/usr/bin/shopt'" >> ~/.zshrc


# install zsh & zi
apt install zsh -y
sh -c "$(curl -fsSL git.io/get-zi)" -- -a annex


DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata

# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" < /dev/null
echo '# Set PATH, MANPATH, etc., for Homebrew.' >> $HOME/.profile
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $HOME/.profile
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $HOME/.zshrc
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $HOME/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
echo 'export $PATH=$PATH:/home/linuxbrew/.linuxbrew/bin/brew' >> $HOME/.bashrc
. $HOME/.bashrc &&


brew install z
brew install gcc
brew install jandedobbeleer/oh-my-posh/oh-my-posh
brew install gh


HOMEBREW=/home/linuxbrew/.linuxbrew

cat .ref.zshrc >> $HOME/.zhrc
cat .ref.zshenv >> $HOME/.zshenv


echo ". /home/linuxbrew/.linuxbrew/etc/profile.d/z.sh" >> $HOME/.zshrc

apt update -y
apt install npm -y

# micro editor with plugins
brew install micro

micro -plugin install nordcolors
micro -plugin install autofmt
micro -plugin install misspell
micro -plugin install filemanager


eval "cp arno-pure-bayes.omp.json $(brew --prefix oh-my-posh)/themes/arno-pure.omp.json"
cp -r micro/ $HOME/.config/

## add this to your .zshrc for zi

brew install python3

echo 'path+=/home/linuxbrew/.linuxbrew/opt/python@3.11/libexec/bin' >> $HOME/.zshenv
echo 'export $PATH=$PATH:/home/linuxbrew/.linuxbrew/opt/python@3.11/libexec/bin' >> $HOME/.bashrc

(echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /root/.zprofile
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

echo "source ~/.zi/bin/zi.zsh" >> $HOME/.zshrc
chsh -s /bin/zsh
exec zsh

eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/arno-pure.omp.json)"

curl -sSL https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh > miniconda-install.sh

/bin/bash miniconda-install.sh -b
