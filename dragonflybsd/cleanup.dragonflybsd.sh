#!/bin/sh

# Accelerate boot
echo 'autoboot_delay="0"' >>/boot/loader.conf

# To avoid loosing this package when git is removed.
pkg set -y -A 0 ca_root_nss &&

# Remove non-critical packages and clear cache
pkg remove -y wpa_supplicant isc-dhcp44-server bind-tools cdrtools git &&
    pkg autoremove -y &&
    pkg clean -y

# Remove some groups and users.
pw groupdel dhcpd
pw groupdel git_daemon
pw userdel _dhcpd

# Clear LiveCD files
rm -rf /README* /autorun /index.html /dflybsd.ico /etc.hdd /boot.catalog

# Clear source code
rm -rf /usr/src/*

# Clear core dumps
rm -f /*.core

# Clear log files
find /var/log -type f | xargs truncate -s 0

# Clear temporary files
rm -rf /tmp/*

# Shrink swap space

swappart=$(swapctl -l | awk '!/^Device/ { print $1 }') &&
    swapctl -d "$swappart" &&
    dd if=/dev/zero of="$swappart" bs=1M ||
    echo 'Zeroed swap space' &&
    sync
