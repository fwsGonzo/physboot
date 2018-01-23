pushd /usr/lib/vmware/modules/source
sudo insmod vmmon-only/vmmon.ko
sudo insmod vmnet-only/vmnet.ko
sudo vmware-networks --start
/usr/lib/vmware/bin/vmware
