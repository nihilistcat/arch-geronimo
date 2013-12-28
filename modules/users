#!/bin/bash

# user management

# change root password

echo "root:newrootpassword" | chpasswd

# create new user

useradd -m -g users -G wheel,storage,power -s /bin/bash newuser

# set password for new user

echo "newuser:mypassword" | chpasswd
