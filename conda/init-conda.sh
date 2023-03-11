conda create --name remote -y
conda init zsh
exec zsh
conda activate remote
conda install -c fastchan fastai -y
