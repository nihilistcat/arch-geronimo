#!/bin/bash

# grub stuff

pacman --noconfirm -S grub-bios
grub-install targethdd
cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo
grub-mkconfig -o /boot/grub/grub.cfg
