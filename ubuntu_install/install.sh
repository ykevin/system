#更新系统源
sudo apt-get update

#1、安装五笔,然后重启系统,谷歌拼音
sudo apt-get install -y ibus-table-wubi ibus-googlepinyin 

#2、安装系统工具
sudo apt-get install -y nautilus-open-terminal vim git cscope ctags openssh-server libtool automake minicom python-pip

#3、安装开发工具
sudo apt-get install -y build-essential python-virtualenv

#建立不同版本的Python开发环境
# virtualenv -p python3.5 pvenv3.5

#解决/usr/local/lib库的问题
echo export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/ >> ~/.bashrc

