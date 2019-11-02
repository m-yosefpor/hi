#!/bin/bash
##### a bash script for new os use with : bash 0_start
######################################################################
TYPE = $1 # gtk , cli
######################################################################
### updating repos
sudo apt update



if [ $1 == 'gtk' ]
then
### removing some apps if exist 
  sudo apt remove -y firefox eog
  sudo snap install firefox eog vlc telegram-desktop #evince gimp libreoffice audacity

  sudo apt remove -y gedit totem rhythmbox file-roller #yelp
  sudo snap remove gnome-calculator gnome-system-monitor

  ### install required packages
  sudo apt install -y gnome-terminal thunderbird nautilus evince cheese gnome-screenshot gnome-tweak-tool brasero vim-gtk#gimp libreoffice openshot
fi

sudo apt install -y git tmux wget openconnect htop xclip vim
sudo apt install -y ubuntu-restricted-extras


### make sure everything is uptodate
sudo apt -y upgrade

#################### rc files
cp bashrc ~/.bashrc
cp bash_aliases ~/.bash_aliases
cat bash_aliases_pv >> ~/.bash_aliases
cp tmux.conf ~/.tmux.conf
cp vimrc ~/.vimrc

if [ $1 == 'gtk' ]
then
  cat vimrc-gtk >> ~/.vimrc
fi

#################### rename and make directories
rmdir ~/Musics ~/Videos ~/Pictures ~/Documents ~/Public
mkdir ~/0.github ~/1.other

##################### python3 config
sudo apt install -y python3 python3-dev python3-venv
cd ~
python3 -m venv py-venv
. py-venv/bin/activate
### need a vpn
pip install wheel
pip install numpy
pip install scipy
pip install pandas
pip install matplotlib
pip install numba
pip install sympy
pip install cython
pip install sklearn
pip install tensorflow
pip install qutip
pip install jupyter
deactivate

###################### config git
sudo apt install -y git
git config --global user.name 'm-yosefpor'
git config --global user.email 'myusefpur@gmail.com'
git config --global core.editor vim
git config --global merge.tool vimdiff
###
ssh-keygen -t rsa -b 4096 -C "myusefpur@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
###
#xclip -sel clip < ~/.ssh/id_rsa.pub
## add ssh-key to github accoutn : #setting # ssh and gpg key # add ssh key
#####
mkdir ~/0.github/docs.git
cd ~/0.github/docs.git
git init
git remote add origin git@github.com:/m-yosefpor/docs.git
git remote add horigin https://github.com/m-yosefpor/docs.git
git pull horigin master



#################### vundle install and jedi-vim auto completion
#git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
#vim +PluginInstall +qall

#################### installing by file
#cp app/dropbox /opt/dropbox
#ln -s /opt/dropbox/dropbox.py /usr/local/bin/dropbox 'dropbox'


###################### config tor
sudo apt install -y tor privoxy obfs4proxy
cat torrc | sudo tee -a /etc/tor/torrc >/dev/null
echo "forward-socks5 / 127.0.0.1:9050 ." > ~/.privoxy.conf







################# apps and defaults
sudo cp nvlc.desktop /usr/share/applications/nvlc.desktop
cp mimeapps.list ~/.config/mimeapps.list
