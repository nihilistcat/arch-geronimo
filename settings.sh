#!/bin/bash
echo "Run advanced installation steps? (gui/aur/drivers)"
select yn in "Yes" "No"; do
	case $yn in
		Yes ) break ;;
		No ) exit ;;
	esac
done

echo "Do you want a desktop?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) echo "installing xorg and synaptics drivers" ;
			pacman --noconfirm -S mesa xorg-server xorg-xinit xf86-input-synaptics xf86-input-mouse ;
			echo "Choose a Desktop Environtment"
			options=("cinnamon" "xfce" "gnome" "kde" "lxde")
			select opt in "${options[@]}"; do
				case $opt in
					cinnamon ) echo "Installing cinnamon" ; pacman --noconfirm -S cinnamon ; cp /etc/skel/.xinitrc /home/newuser/ ; echo "exec cinnamon-session" >> /home/newuser/.xinitrc ; echo "Completed" ; break ;;
					xfce ) echo "Installing xfce" ; pacman --noconfirm -S xfce4 ; cp /etc/skel/.xinitrc /home/newuser/ ; echo "exec xfce4-session" >> /home/newuser/.xinitrc ; echo "Completed" ; break ;;
					gnome ) echo "Installing gnome" ; pacman --noconfirm -S gnome ; cp /etc/skel/.xinitrc /home/newuser/ ; echo "exec gnome-session" >> /home/newuser/.xinitrc ; echo "Completed" ; break ;;
					kde ) echo "Installing kde" ; pacman --noconfirm -S kdebase ; cp /etc/skel.xinitrc /home/newuser/ ; echo "exec startkde" >> /home/newuser/.xinitrc ; echo "Completed" ; break ;;
					lxde ) echo "Installing lxde" ; pacman --noconfirm -S lxde ; cp /etc/skel/.xinitrc /home/newuser/ ; echo "exec startlxde" >> /home/newuser/.xinitrc ; echo "Completed" ; break ;;
				esac
			done ; echo "Done with installing a Desktop, upon login, execute startx" ; break ;;
        No ) break ;;
    esac
done

## Arch User Repository helper installer

echo -e "Do you want to enable AUR helper (yaourt) ?\nKeep in mind this will require base-devel"
select yn in "Yes" "No" ; do
	case $yn in
		Yes ) pacman --noconfirm -S base-devel wget ; wget https://aur.archlinux.org/packages/pa/package-query/package-query.tar.gz ; tar xzf package-query.tar.gz ; cd package-query ; makepkg --asroot --noconfirm -s -i ; cd .. ; wget https://aur.archlinux.org/packages/ya/yaourt/yaourt.tar.gz ; tar xzf yaourt.tar.gz ; cd yaourt ; makepkg --asroot --noconfirm -s -i ; cd .. ; rm -rf package-query.tar.gz yaourt.tar.gz package-query yaourt ;  echo "done" ; break ;;
		No ) echo "Ok, suite yourself.." ; break ;;
	esac
done

## infinality installer - need to work on auto prompt answer
echo -e "Do you want better font rendering with Infinality?\n Choose yes when prompted to replace freetype2" 
select yn in "Yes" "No" ; do
	case $yn in
		Yes ) wget https://aur.archlinux.org/packages/fo/fontconfig-infinality/fontconfig-infinality.tar.gz ; tar xzf fontconfig-infinality.tar.gz ; cd fontconfig-infinality ; makepkg --asroot -s -i ; cd .. ; rm -rf fontconfig-infinality.tar.gz fontconfig-infinality ; echo "choose a style" ; infctl setstyle ; echo "Done" ; break ;;
		No ) echo "Fine.." ; break ;;
	esac
done

## install graphics driver
echo "Would you like to install graphics driver?"
select yn in "Yes" "No"; do
	case $yn in
		Yes ) sleep 1 ; break ;;
		No ) echo "Finished with settings" ; break ;;
	esac
done

echo -e "Choose your graphics\nNOTE: The proprietary drivers are usually for newer gpus. If you are using an old gpu, pls. go with the opensource driver"
options=("intel" "amd" "nvidia")
select opt in "${options[@]}"; do
	case $opt in
		intel ) echo "Installing intel graphics drivers" ; pacman --noconfirm -S xf86-video-intel libva-intel-driver ; echo "Done" ; break ;;
		amd ) echo -e "Installing amd ati drivers\nDo you want opensource or proprietary?"
				select yn in "opensource" "proprietary"; do
					case $yn in
						opensource ) pacman --noconfirm -S  xf86-video-ati ; echo "Completed" ; break;;
						proprietary ) echo -e "[catalyst]\nServer = http://catalyst.wirephire.com/repo/catalyst/\$arch" >> /etc/pacman.conf ; pacman-key --keyserver pgp.mit.edu --recv-keys 0xabed422d653c3094 ; pacman-key --lsign-key 0xabed422d653c3094 ; pacman -Syy && pacman --noconfirm -S catalyst ; echo "Completed" ; break ;;
					esac
				done ; break ;;
		nvidia ) echo -e "Installing nvidia graphics drivers (eww)\nDo you want opensource or proprietary?"
					select yn in "opensource" "proprietary"; do
						case $yn in
							opensource ) pacman --noconfirm -S xf86-video-nouveau ; echo "Completed" ; break;;
							proprietary ) pacman --noconfirm -S nvidia ; echo "Completed" ; break ;;
						esac
					done ;;
	esac
done
