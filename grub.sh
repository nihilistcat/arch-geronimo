#!/bin/bash

# grub stuff

pacman --noconfirm -S grub
grub-mkconfig -o /boot/grub/grub.cfg
grub-install targethdd
