#!/bin/bash

#locale setup

sed -i -e s,#mylocale,mylocale,g /etc/locale.gen
locale-gen
echo LANG=mylocale > /etc/locale.conf
export LANG=mylocale

# time setup

ln -s /usr/share/zoneinfo/MainZone/SubZone /etc/localtime
hwclock --systohc --utc

#hostname setup

echo myhostname > /etc/hostname
