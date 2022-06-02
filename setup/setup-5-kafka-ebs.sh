#!/bin/bash

# execute commands as root
sudo su

# Attach the EBS volume in the console, then
# view available disks
lsblk

# we verify the disk is empty - should return "data"
file -s /dev/sdc

# Note on Kafka: it's better to format volumes as xfs:
# https://kafka.apache.org/documentation/#filesystems
# Install packages to mount as xfs
apt-get install -y xfsprogs

# create a partition
# fdisk /dev/sdc
parted /dev/sdc --script mklabel gpt mkpart xfspart xfs 0% 100%

# format as xfs
mkfs.xfs -f /dev/sdc

# create kafka directory
mkdir /data/kafka
# mount volume
mount -t xfs /dev/sdc /data/kafka
# add permissions to kafka directory
chown -R root:root /data/kafka
# check it's working
df -h /data/kafka

# EBS Automount On Reboot
cp /etc/fstab /etc/fstab.bak # backup
blkid
echo 'UUID=db6742e7-3ca0-4a5d-aa5b-0d3a1d03fe18 /data/kafka xfs   defaults,nofail   1   2' >> /etc/fstab
cat /etc/fstab
# echo '/dev/xvdf /data/kafka xfs defaults 0 0' >> /etc/fstab

# Verify
lsblk -o NAME,HCTL,SIZE,MOUNTPOINT | grep -i "sd"

# reboot to test actions
reboot
service zookeeper start

reference: https://docs.microsoft.com/en-us/azure/virtual-machines/linux/attach-disk-portal