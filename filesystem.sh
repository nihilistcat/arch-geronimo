#!/bin/bash

# file system operations

mkfs.ext4 rootfs
mkswap swapfs
swapon swapfs
mkdir /mnt
mount rootfs /mnt
