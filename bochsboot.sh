#!/bin/bash
set -e
SERVICE=${1:-"/home/gonzo/github/IncludeOS/examples/IRCd/build/IRCd"}
SERVICE_DIR=$(dirname "${SERVICE}")
echo $SERVICE_DIR

# build service
pushd $SERVICE_DIR
cmake .. -DREAL_HW=ON
make -j
popd

LOCAL_DISK=temp_disk
DISK=/dev/sdc

# create grub.iso
mkdir -p $LOCAL_DISK/boot/grub
cp $SERVICE $LOCAL_DISK/boot/service
cp grub.cfg $LOCAL_DISK/boot/grub
echo "=>"
grub-mkrescue -o grub.iso $LOCAL_DISK
echo "grub.iso constructed"

# go!
#bochs -q
