#!/bin/bash 

set -e

DIR=${PWD}
echo "Current Dir is : ${DIR}"

#更新系统源
#sudo apt-get update

#add vimrc and vundle manager
sudo cp ${DIR}/../vim/vimrc /etc/vim/
mkdir -p ~/.vim/autoload ~/.vim/bundle 
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
cd ~/.vim/bundle 
git clone http://github.com/gmarik/vundle.git  

