#!/bin/bash

# Installer for Lustre file system over ZFS

# disable firewalld / any firewall
if systemctl status firewalld > /dev/null 2>&1; then 
    echo Firewalld is active need to disable and shut down.
    sudo systemctl disable firewalld
    sudo systemctl stop firewalld
    sudo systemctl mask firewalld
fi

# set seslinux to disabled
# if grep "enforcing" /etc/selinux/config > /dev/null 2>&1; then
#     sudo cp /etc/selinux/config /etc/selinux/bak-config
#     sudo sed -i 's/SELINUX=enforcing/SELINUX=disable/g' /etc/selinux/config
#     sudo dnf -y update --exclude=kernel* --exclude=kmod-kvdo
#     sudo reboot
# fi

if grep "enforcing" /etc/selinux/config > /dev/null 2>&1; then
    sudo cp /etc/selinux/config /etc/selinux/bak-config
    sudo sed -i 's/SELINUX=enforcing/SELINUX=disable/g' /etc/selinux/config
    sudo reboot
fi

echo Kernel $(uname -r)

## installing ZFS on OS
sudo dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
sleep 1
sudo dnf -y install https://zfsonlinux.org/epel/zfs-release-2-3$(rpm --eval "%{dist}").noarch.rpm

# sudo yum install kernel-devel-4.18.0-553.16.1.el8_10.x86_64

sudo dnf -y install kernel-devel-$(uname -r)
sudo dnf -y install zfs

sleep 1

## is ZFS is up and added to the kernel
echo $(sudo modprobe -v zfs)

dmesg | tail -n3

cat > /etc/yum.repos.d/lustre.repo <<EOF
[lustre-server]
name=lustre-server
baseurl=https://downloads.whamcloud.com/public/lustre/latest-release/el8.10/server/
exclude=*debuginfo*
enabled=0
gpgcheck=0
EOF

sudo yum config-manager --set-enabled powertools
sudo yum -y install libyaml-devel
sudo yum -y install python3-devel

sudo dnf --enablerepo=lustre-server install lustre-dkms lustre-osd-zfs-mount lustre




