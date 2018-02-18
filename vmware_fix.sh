cd /usr/lib/vmware/modules/source
pushd vmmon-only
#sudo make clean
#sudo make -j
sudo insmod vmmon.ko
popd
pushd vmnet-only
#sudo make clean
#sudo make -j
sudo insmod vmnet.ko
popd
sudo vmware-networks --start
/usr/lib/vmware/bin/vmware
