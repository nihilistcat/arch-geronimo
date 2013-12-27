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
sed -i -e s,rootfs,"$name",g filesystem.sh
echo "What should be the swap partition? e.g. /dev/sda2: "
read name
sed -i -e s,swapfs,"$name",g filesystem.sh
echo "Where to install grub? e.g. /dev/sda: "
read name
sed -i -e s,targethdd,"$name",g grub.sh

#locale selection
echo "What is your locale? e.g. en_US.UTF-8: "
read name
sed -i -e s,mylocale,"$name",g lth.sh

# timezone selection
echo "What is your main time zone? e.g. America: "
read name
sed -i -e s,MainZone,"$name",g lth.sh
echo "What is your sub zone? e.g. New_York: "
read name
sed -i -e s,SubZone,"$name",g lth.sh

# hostname configuration
echo "What should be your hostname? e.g. archer: "
read name
sed -i -e s,myhostname,"$name",g lth.sh

# wired network configuration
echo "What is your wired network interface?: "
read name
sed -i -e s,interfacename,"$name",g wired.sh

# user configuration
echo "What should be the root password?: "
read name
sed -i -e s,newrootpassword,"$name",g users.sh
echo "What should be the name for the non-root user?: "
read name
sed -i -e s,newuser,"$name",g users.sh
sed -i -e s,newuser,"$name",g settings.sh
echo "What should be the password for the non-root user?: "
read name
sed -i -e s,mypassword,"$name",g users.sh

echo "Alright then, geronimo!"
sleep 1

# configure filesystems
chmod +x filesystem.sh
./filesystem.sh

# install base
pacstrap /mnt base

# generate fstab

genfstab -U -p /mnt >> /mnt/etc/fstab

# copy scripts to the chroot directory

cp lth.sh wired.sh users.sh visudo.sh settings.sh grub.sh /mnt

# now we chroot into the base system and execute the scripts
arch-chroot /mnt /bin/bash -c "chmod +x lth.sh wired.sh users.sh visudo.sh settings.sh grub.sh ; ./lth.sh ; ./wired.sh ; ./users.sh ; ./visudo.sh ; ./settings.sh ; grub.sh ; rm lth.sh wired.sh users.sh visudo.sh settings.sh grub.sh ; exit"

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





