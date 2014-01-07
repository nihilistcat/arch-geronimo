**Simple install script for Arch Lnux written in bash**


This is a project for me to learn bash, it's noobishly written but works fine for me. On a good internet connecton it can install a basic Arch system in under 5 minutes.

The installation process is aimed for new Arch users with old machines (for quickly erasing and setting up Arch) and closely follows the beginners installation guide (see [ArchWiki](https://wiki.archlinux.org/index.php/Beginners'_Guide).)

Current features:
* Install Archlinux on a MBR disk with one swap and one root partition.
* Set up locale/timezone/hostname and user with root privileges
* Install AUR helper yaourt
* Perform fontconfig patch 'infinality' for better font rendering
* Install Xorg server, synaptic input drivers and one base DE (gnome, cinnamon, kde, xfce or lxde)
* Install intel graphics drivers plus nvidia/amd drivers (proprietary or open-source)

There is no support for advanced features like UEFI/GPT. But, due to the modular structure a simple script can be written to achieve this task.

__________
**Instructions**
* boot archiso
* install git (pacman -S git) / You might have to sync repos first with 'pacman -Syy'
* clone this repo
* cd into the dir, run 'chmod +x geronimo' to make executable
* discover your ethernet with 'ip link' (usually starts with e like enp0s15)
* use fdisk to partition drive with 1 swap and 1 root ([tutorial](https://www.gentoo.org/doc/en/handbook/handbook-x86.xml?part=1&chap=4#doc_chap4))
* execute ./geronimo


_______

TODO:

* add uefi support
* add simple disk partitioning script
* clean up code and increase efficiency/speed.
