#!/bin/bash 

set -e

DIR=${PWD}
echo "Current Dir is : ${DIR}"

#更新系统源
sudo apt-get update

#1、安装五笔,然后重启系统,谷歌拼音
#sudo apt-get install -y ibus-table-wubi ibus-googlepinyin 

#2、安装系统工具
sudo apt-get install -y ssh vim git cscope ctags openssh-server libtool automake minicom python-pip tmux gcc-arm-none-eabi meld

#3、安装开发工具
sudo apt-get install -y build-essential python-virtualenv

#add vimrc and vim plugin
sudo cp ${DIR}/../vim/vimrc /etc/vim/
sudo cp ${DIR}/../vim/plugin/* /usr/share/vim/vim74/ -rf

#add git auto completion
cd ${DIR}/../ 
git submodule update --init &&
cp ./git-bash-completion/git-completion.bash ~/.git-completion.bash 
echo "source ~/.git-completion.bash" >> ~/.bashrc

#add git save password
git config --global credential.helper store 
cp  ${DIR}/../.ssh  ~/ -rf

#建立不同版本的Python开发环境
#sudo apt-get install python3.5-dev
# virtualenv -p python3.5 pvenv3.5

#解决/usr/local/lib库的问题
echo export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/ >> ~/.bashrc

source ~/.bashrc
