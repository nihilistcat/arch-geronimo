**Simple install script for Arch Lnux written in bash**


This is a project for me to learn bash, it's noobishly written but works fine for me. On a good internet connecton it can install Arch in under 5 minutes.

The installation process is aimed for new Arch users and closely follows the beginners installation guide (see ArchWiki).

Current features:
* Install Archlinux on a MBR disk with one swap and one root partition.
* Set up locale/timezone/hostname and user with root privileges
* Install AUR helper yaourt
* Perform fontconfig patch 'infinality' for better font rendering
* Install Xorg server, synaptic input drivers and one base DE (gnome, cinnamon, kde, xfce or lxde)
* Install intel drivers plus nvidia/amd drivers (proprietary or open-source)

There is no support for advanced features like UEFI/GPT. But, due to the modular structure a simple script can be written to achieve this task.

* boot archiso
* install git (pacman -S git)
* clone this repo
* cd into the dir, run 'chmod +x geronimo.sh'
* discover your ethernet with 'ip link'
* use fdisk to partition drive with 1 swap and 1 root
* execute ./geronimo


_______

TODO:

* add uefi support
* add simple disk partitioning script
* clean up code and increase efficiency/speed.
