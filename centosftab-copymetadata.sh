#!/bin/bash

echo "Argument List is $*"

deploymentName=$1
region=$2
vnet=$3
cdir=$4
subnet=$5
subscription=$6
storagename=$7

# Set value to be used for filesystem mount point folder
# this will be the first param passed into the script execution
mp=$8

# masterIP
masterIP=$9 

#shift until there is only one parameter left.
while (( $# > 2 ))
do
  shift
done

publicsubnetname=$1
privatesubnetname=$2

echo "The last argument after shifting is $1"

# write content to file in /etc/metadata

printf '{"deploymentName":"%s","region":"%s","vnet":"%s","cdir":"%s","subnet":"%s","subscription":"%s","storagename":"%s", "privatesubnetname":"%s", "publicsubnetname":"%s"}\n' "$deploymentName" "$region" "$vnet" "$cdir" "$subnet" "$subscription" "$storagename" "$privatesubnetname" "$publicsubnetname">> /etc/orca-master.json

# begin mounting disk

# Set bash script options
set -o nounset
set -o errexit

# Install mdadm on Centos
#yum --disablerepo=orchestrator -y install mdadm

# Create backup copy of fstab
#sudo cp /etc/fstab /etc/fstab.orig

# Enumerate data disks attached to VM 
# Leverages udev rules for Azure storage devices located at https://github.com/Azure/WALinuxAgent/blob/2.0/config/66-azure-storage.rules
#attached=`basename -a $(find /sys/class/block -name 'sd[a-z]')`
#reserved=`basename -a $(readlink -f /dev/disk/azure/root /dev/disk/azure/resource)`
#datadisks=(${attached[@]/$reserved})

# Set value to be used for filesystem label - max length 16 chars
#fslabel=$(hostname | cut -c1-10)-$mp

# Set value for filesystem barriers - 0 if using Premium Storage w/ ReadOnly Caching or NoCache; 1 otherwise
#b=0

# Set value for initial RAID command string used to span multiple data disks
#RAID_CMD="mdadm --create /dev/md1 --level 0 --raid-devices ${#datadisks[@]} "

# Loop through each data disk, fdisk and add to RAID command string
#for d in "${datadisks[@]}"; do
#    disk="/dev/${d}"
#    (echo n; echo p; echo 1; echo ; echo ; echo t; echo fd; echo p; echo w;) | fdisk ${disk}
#    RAID_CMD+="${disk}1 "
#done

#RAID_CMD+=" --force"

# Build RAID device
#eval "$RAID_CMD"

# Format and label filesystem
#mkfs.ext4 /dev/md1 -L ${fslabel}

# Set value of UUID for new filesystem
#uuid=$(blkid -p /dev/md1 | grep -oP '[-a-z0-9]{36}')

# Create mount point folder
#mkdir -p /media/${mp}

# Add new filesystem to working copy of fstab
#echo "UUID=${uuid} /media/${mp} ext4 defaults,noatime,barrier=${b} 0 0" >> /etc/fstab

# Mount all unmounted filesystems
#mount -a

sudo yum install -y --disablerepo=* --enablerepo=foundation  consul vault terraform orchestrator  ipahelper ui-setup rpminstall azmgr
