#!/bin/bash
FROM ubuntu:latest

RUN apt upgrade -y
RUN apt install vim -y
RUN apt install apt-utils -y
RUN apt install curl git gcc -y
RUN apt update -y

RUN apt install build-essentials -y
RUN apt install ruby -y

RUN apt install postgresql postgresql-contrib
RUN systemctl start postgresql.service

# use your creds
RUN git config --global user.email "bcda0276@gmail.com"
RUN git config --global user.name "arnos-stuff"

RUN echo "#! /bin/bash\n\nshopt \$*\n" > /usr/local/bin/shopt
RUN chmod +x /usr/local/bin/shopt
RUN ln -s /usr/local/bin/shopt /usr/bin/shopt
RUN echo "alias shopt='/usr/bin/shopt'" >> ~/.zshrc


# install zsh & zi
RUN apt install zsh -y
RUN /bin/bash -c "$(curl -fsSL git.io/get-zi)" -- -a annex


ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y --no-install-recommends tzdata

# install brew
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" < /dev/null

RUN echo '# Set PATH, MANPATH, etc., for Homebrew.' >> $HOME/.profile \
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $HOME/.profile \
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $HOME/.zshrc \
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $HOME/.bashrc \
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" \
    echo 'export $PATH=$PATH:/home/linuxbrew/.linuxbrew/bin/brew' >> $HOME/.bashrc 

RUN . $HOME/.bashrc &&


RUN brew install z \
     install gcc \
     install jandedobbeleer/oh-my-posh/oh-my-posh \
     install gh


ENV HOMEBREW=/home/linuxbrew/.linuxbrew

RUN cat .ref.zshrc >> $HOME/.zhrc
RUN cat .ref.zshenv >> $HOME/.zshenv


RUN echo ". /home/linuxbrew/.linuxbrew/etc/profile.d/z.sh" >> $HOME/.zshrc

RUN apt update -y \
    apt install npm -y

# micro editor with plugins
RUN brew install micro \
    micro -plugin install goyo \
    micro -plugin install colorscheme \
    micro -plugin install nordcolors \
    micro -plugin install autofmt \
    micro -plugin install misspell \
    micro -plugin install filemanager


RUN eval "cp arno-pure-bayes.omp.json $(brew --prefix oh-my-posh)/themes/arno-pure.omp.json"
RUN cp -r micro/ $HOME/.config/

## add this to your .zshrc for zi

RUN brew install python3

RUN echo 'path+=/home/linuxbrew/.linuxbrew/opt/python@3.11/libexec/bin' >> $HOME/.zshenv \
    echo 'export $PATH=$PATH:/home/linuxbrew/.linuxbrew/opt/python@3.11/libexec/bin' >> $HOME/.bashrc

RUN (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /root/.zprofile
RUN eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

RUN echo "source ~/.zi/bin/zi.zsh" >> $HOME/.zshrc \
    echo "source ~/.zi/bin/zi.zsh" >> $HOME/.zshenv \
    echo "source ~/.zi/bin/zi.zsh" >> $HOME/.bashrc \
    echo "source ~/.zi/bin/zi.zsh" >> $HOME/.profile

RUN chsh -s /bin/zsh
RUN exec zsh

RUN eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/arno-pure.omp.json)"

RUN curl -sSL https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh > miniconda-install.sh

RUN /bin/bash miniconda-install.sh -b

RUN echo 'export PATH="/root/miniconda3/bin:$PATH"' >> $HOME/.bashrc \
    echo 'export PATH="/root/miniconda3/bin:$PATH"' >> $HOME/.zshrc \
    echo 'export PATH="/root/miniconda3/bin:$PATH"' >> $HOME/.zshenv \
    echo 'export PATH="/root/miniconda3/bin:$PATH"' >> $HOME/.profile

RUN conda init zsh

RUN conda env create -n VM --file condaVM.yml

RUN conda activate VM

