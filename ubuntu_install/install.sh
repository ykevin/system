#!/bin/bash 

set -e

DIR=${PWD}
echo "Current Dir is : ${DIR}"

#更新系统源
#sudo apt-get update

#1、安装五笔,然后重启系统,谷歌拼音
#sudo apt-get install -y ibus-table-wubi ibus-googlepinyin 

#2、安装系统工具
sudo apt-get install -y ssh vim git cscope ctags openssh-server libtool automake minicom python-pip tmux gcc-arm-none-eabi meld sshpass chromium-browser cmake ibus-pinyin

#3、安装开发工具
sudo apt-get install -y build-essential python-virtualenv

#add vimrc and vundle manager
sudo cp ${DIR}/../vim/vimrc /etc/vim/
mkdir -p ~/.vim/autoload ~/.vim/bundle 
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
cd ~/.vim/bundle 
git clone http://github.com/gmarik/vundle.git  

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

echo -n "Need Arduino and ino, Please select yes(y) or no(n) :"
read Value
if [ $Value == "y" -o $Value == "yes" ]; then
	echo "Install Arduino "
	sudo apt-get install -y arduino-core clang
	sudo pip install ino platformio
elif [ $Value == "n" -o $Value == "no" ]; then
	echo "Skip Arduino Install"
else
	echo "Skip Arduino Install"
fi

echo -n "Need Ros system, Please select yes(y) or no(n) :"
read Value
if [ $Value == "y" -o $Value == "yes" ]; then
	echo "Install ROS!"
	sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
	sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
	sudo apt-get update
	sudo apt-get install ros-kinetic-desktop-full
	sudo rosdep init
	rosdep update
	echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
	source ~/.bashrc
elif [ $Value == "n" -o $Value == "no" ]; then
	echo "Skip ROS Install"
else
	echo "Skip ROS Install"
fi


echo -n "Need Atom IDE, Please select yes(y) or no(n) :"
read Value
if [ $Value == "y" -o $Value == "yes" ]; then
	echo "Install Atom IDE"
	sudo add-apt-repository ppa:webupd8team/atom  
	sudo apt-get update  
	sudo apt-get install atom 
elif [ $Value == "n" -o $Value == "no" ]; then
	echo "Skip Atom Install"
else
	echo "Skip Atom Install"
fi
