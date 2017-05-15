System Setting Default
======================
#### personal develop  config, include:

* vim config and vunble plugin
* tmux
* ubuntu system install bash and vim plugin auto manager
* git auto completion
* add ssh remote password 
* add rapsberry create img bash
* add rapsberry ubuntu mate install bash

#### Install ubuntu
> $cd ubuntu_install/  
$chmod +x install.sh  
$./install.sh

#### Install raspberry pi3 ubuntu mate
> $cd rasp-cofig  
$./Mateinstall.sh

#### make img file for raspberry pi3
> $cd rasp-config  
$./buildRaspImg.sh


#### add serial driver ch340g 
> $sudo cp ch34x.ko /lib/modules/$(uname -r)/kernel/drivers/usb/serial  
$sudo depmod  
$sudo rm /lib/modules/$(uname -r)/kernel/drivers/usb/serial/ch341.ko 
