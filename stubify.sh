#!/bin/bash
set -e
DEVICE=${1:-"0000:06:00.0"}

# unbind
echo $DEVICE > /sys/bus/pci/devices/$DEVICE/driver/unbind
# extract PCI id
PCI_ID=`lspci -s $DEVICE -n | cut -d " " -f 3 | tr : " "`
echo "Device PCI id: $PCI_ID"
# bind to vfio-pci driver
echo $PCI_ID > /sys/bus/pci/drivers/vfio-pci/new_id
