#!/bin/sh
echo "--------install package------------"
sudo apt-get install -y dosfstools parted kpartx rsync

echo "------calculate resize after total size, (root+boot)*1.1-----"
df=`df -P | grep /dev/root | awk '{print $3}'`
dr=`df -P | grep /dev/mmcblk0p1 | awk '{print $2}'`
df=`echo $df $dr |awk '{print int(($1+$2)*1.1)}'`

echo "-------build space img file------"
sudo dd if=/dev/zero of=raspberrypi.img bs=1K count=$df
sudo parted raspberrypi.img --script -- mklabel msdos

echo "-----disk start and end size, if other img modfiy about param------"
start=`sudo fdisk -l /dev/mmcblk0| awk 'NR==9 {print $2}'`
start=`echo $start's'`
end=`sudo fdisk -l /dev/mmcblk0| awk 'NR==9 {print $3}'`
end2=`sudo fdisk -l /dev/mmcblk0| awk 'NR==10 {print $2}'`
end=`echo $end's'`
end2=`echo $end2's'`

sudo parted raspberrypi.img --script -- mkpart primary fat32 $start $end
sudo parted raspberrypi.img --script -- mkpart primary ext4 $end2 -1

echo "--------build virtual disk-------"
loopdevice=`sudo losetup -f --show raspberrypi.img`
device=`sudo kpartx -va $loopdevice | sed -E 's/.*(loop[0-9])p.*/\1/g' | head -1`
device="/dev/mapper/${device}"
partBoot="${device}p1"
partRoot="${device}p2"

echo "----------format virtual disk --------"
sudo mkfs.vfat $partBoot
sudo mkfs.ext4 $partRoot

echo "---------backup boot disk-------"
sudo mount -t vfat $partBoot /media
sudo cp -rfp /boot/* /media/
sudo umount /media

echo "---------backup root disk--------"
sudo mount -t ext4 $partRoot /media/
cd /media
sudo rsync -aP --exclude="raspberrypi.img" --exclude=/media/* --exclude=/sys/* --exclude=/proc/*  --exclude=/tmp/* / ./

echo "-----------umount all device---------"
cd
sudo umount /media
sudo kpartx -d $loopdevice
sudo losetup -d $loopdevice
