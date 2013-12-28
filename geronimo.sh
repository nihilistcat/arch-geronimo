#!/bin/bash

echo "Hi! Welcome to this stupidly simple arch install script, few things you should know:"
echo " "
echo "1. Use cfdisk to define your root and swap partitions first!"
echo "2. Use 'ip link' to find out your wired interface name"
echo "3. Make a backup of the 'INSTALLER' folder"
echo "4. The installation CANNOT be resumed once it's interrupted, start fresh from the backup!"
echo " "
echo "Good luck!"
echo " "
sleep 1
echo "Are you ready to begin the process?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) sleep 1; break;;
        No ) exit;;
    esac
done

# interactive configuration
# filesystem selection
echo "What should be the root filesystem? e.g. /dev/sda1: "
read name
sed -i -e s,rootfs,"$name",g modules/filesystem
echo "What should be the swap partition? e.g. /dev/sda2: "
read name
sed -i -e s,swapfs,"$name",g modules/filesystem
echo "Where to install grub? e.g. /dev/sda: "
read name
sed -i -e s,targethdd,"$name",g modules/grub

#locale selection
echo "What is your locale? e.g. en_US.UTF-8: "
read name
sed -i -e s,mylocale,"$name",g modules/lth

# timezone selection
echo "What is your main time zone? e.g. America: "
read name
sed -i -e s,MainZone,"$name",g modules/lth
echo "What is your sub zone? e.g. New_York: "
read name
sed -i -e s,SubZone,"$name",g modules/lth

# hostname configuration
echo "What should be your hostname? e.g. archer: "
read name
sed -i -e s,myhostname,"$name",g modules/lth

# wired network configuration
echo "What is your wired network interface?: "
read name
sed -i -e s,interfacename,"$name",g modules/wired

# user configuration
echo "What should be the root password?: "
read name
sed -i -e s,newrootpassword,"$name",g modules/users
echo "What should be the name for the non-root user?: "
read name
sed -i -e s,newuser,"$name",g modules/users
sed -i -e s,newuser,"$name",g modules/settings
echo "What should be the password for the non-root user?: "
read name
sed -i -e s,mypassword,"$name",g modules/users

echo "Alright then, geronimo!"
sleep 1

# configure filesystems
chmod +x modules/filesystem
modules/./filesystem

# install base
pacstrap /mnt base

# generate fstab

genfstab -U -p /mnt >> /mnt/etc/fstab

# copy scripts to the chroot directory

cp modules/* /mnt

# now we chroot into the base system and execute the scripts
arch-chroot /mnt /bin/bash -c "chmod +x lth wired users visudo settings grub ; ./lth ; ./wired ; ./users ; ./visudo ; ./settings ; ./grub ; rm lth wired users visudo settings grub ; exit"

# unmount
umount /mnt

# finish, let's get the fuck out
echo "Installation finished, may or may not be successful, lol. Reboot now?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) reboot; break;;
        No ) exit;;
    esac
done





