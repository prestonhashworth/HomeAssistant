#!/bin/bash
### This presumes you have KVM running on a base Linux system. This script borrowed some virt-install flags from https://community.home-assistant.io/t/install-home-assistant-os-with-kvm-on-ubuntu-headless-cli-only/254941 and is tested on Ubuntu 22.04.4 LTS
### It deploys the files in the Home directory in a subfolder named after the VM.
### 

echo "Name the Home Assistant VM: "
read HA_NAME
mkdir ~/$HA_NAME
cd $HA_NAME
virsh pool-create-as --name $HA_NAME --type dir --target $HA_NAME

wget -O $HA_NAME.qcow2.xz https://github.com/home-assistant/operating-system/releases/download/12.3/haos_ova-12.3.qcow2.xz

xz --decompress $HA_NAME.qcow2.xz 

#virt-resize --expand /dev/sda2 base.qcow2 $HA_NAME.qcow2
#rm base.qcow2

virt-install --import --osinfo detect=on,require=off --name $HA_NAME --ram 2048 --vcpus=2 --cpu host --network bridge=br0.40,model=virtio --accelerate --boot uefi --disk $HA_NAME.qcow2,bus=virtio --noautoconsole --graphics none
