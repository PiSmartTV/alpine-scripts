#!/bin/sh
#from https://wiki.alpinelinux.org/wiki/Alpine_setup_scripts

set -xe



# DEFINE HOSTNAME
TARGET_HOSTNAME="pitv"

# KEYMAP
setup-keymap it it

# SETUP HOSTNAME
setup-hostname -n $TARGET_HOSTNAME

# ETHERNET Configuration
cat <<EOF > /etc/network/interfaces
auto lo
iface lo inet loopback
auto eth0
iface eth0 inet dhcp
    hostname pitv
EOF

#init netowrking
#/etc/init.d/networking --quiet start &
/etc/init.d/networking start &

# DNS SetUp
#setup-dns [-d example.com -n "8.8.8.8 [...]"]

# APK REPOS SetUp
setup-apkrepos -r 

# APK UPDATE and UPGRADE
apk update && apk upgrade


# ROOT password
echo "root:toor" | chpasswd

# TIME
setup-timezone  -z Europe/Rome 

# ENABLE NEW HOSTNAME (pitv)
/etc/init.d/hostname --quiet restart

# SSHD
#setup-sshd -c openssh
apk add openssh

#DISK SETUP
echo "y" | setup-disk -q -m sys /dev/sda
