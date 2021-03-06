#!/bin/sh
set -e

# Use the 'httpredir' Debian mirror
sed -i'' -e 's/\(http\|ftp\).us/httpredir/' /etc/apt/sources.list

# Update
apt-get clean
apt-get update
apt-get upgrade --yes

# Update the kernel
apt-get install --yes linux-image-amd64

# Install dependencies
apt-get install --yes vim

# /etc/sudoers.d/
echo 'sharemind ALL=NOPASSWD:ALL' | tee '/etc/sudoers.d/sharemind'

# /etc/default/grub
cat <<EOF | tee /etc/default/grub
GRUB_DEFAULT=0
GRUB_TIMEOUT=0
GRUB_DISTRIBUTOR=`lsb_release -i -s 2> /dev/null || echo Debian`
GRUB_CMDLINE_LINUX_DEFAULT="quiet"
GRUB_CMDLINE_LINUX="debian-installer=en_US"
GRUB_TERMINAL_OUTPUT=console
GRUB_HIDDEN_TIMEOUT=3
GRUB_HIDDEN_TIMEOUT_QUIET=false
EOF
update-grub
