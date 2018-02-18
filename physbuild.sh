#!/bin/bash
set -e
SERVICE=${1:-"/home/gonzo/github/IncludeOS/examples/IRCd/build/IRCd"}
#SERVICE=${1:-"/home/gonzo/github/IncludeOS/test/kernel/integration/smp/build/smp"}
SERVICE_DIR=$(dirname "${SERVICE}")
echo $SERVICE_DIR

# build service
pushd $SERVICE_DIR
cmake .. -DREAL_HW=ON
make clean
make -j
popd

LOCAL_DISK=temp_disk
DISK=/dev/sdd

# create grub.iso
mkdir -p $LOCAL_DISK/boot/grub
cp $SERVICE $LOCAL_DISK/boot/service
cp grub.cfg $LOCAL_DISK/boot/grub
echo "=>"
grub-mkrescue -d /usr/lib/grub/i386-pc -o grub.iso $LOCAL_DISK
echo "grub.iso constructed"

# install to physical block device
lsblk
echo "=>"
echo "Using $DISK, press Ctrl+C to abort"
echo "====================================="
echo "sudo dd if=grub.iso of=$DISK"
read -rsp $'Press enter to continue...\n'

sudo dd if=grub.iso of=$DISK
