#!/bin/bash

# grub stuff

pacman --noconfirm -S grub
echo "GRUB_DISABLE_SUBMENU=y" >> /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg
grub-install --target=i386-pc --recheck targethdd
