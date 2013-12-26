**simple install script for arch linux written in bash**


This is a project for me to learn bash, it's noobishly written but works fine for me.

The current version is able to install arch linux to a MBR harddrive with one root and one swap partition and it uses the grub boot loader.

You can set up a primary user with sudo privileges alongside the root account, and install opensource/proprietary drivers / desktop environments / synaptics etc.

There is no support for advanced features like UEFI/GPT. But, due to the modular structure a simple script can be written to achieve this task.

* boot archiso
* install git (pacman -S git)
* clone this repo
* cd into the dir
* discover your ethernet with 'ip link'
* use fdisk to partition drive with 1 swap and 1 root
* execute ./geronimo
