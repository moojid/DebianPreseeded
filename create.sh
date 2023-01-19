#!/bin/sh
sudo apt install -y curl xorriso genisoimage
cd ~
curl -LO# https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-11.6.0-amd64-netinst.iso
xorriso -osirrox on -indev debian-11.6.0-amd64-netinst.iso  -extract / isofiles/
chmod +w -R isofiles/install.amd/
gunzip isofiles/install.amd/initrd.gz
echo preseed.cfg | cpio -H newc -o -A -F isofiles/install.amd/initrd
gzip isofiles/install.amd/initrd
chmod -w -R isofiles/install.amd/


chmod +w -R isofiles/boot/grub/grub.cfg
echo "set timeout_style=hidden" >> isofiles/boot/grub/grub.cfg
echo "set timeout=0" >> isofiles/boot/grub/grub.cfg
echo "set default=1" >> isofiles/boot/grub/grub.cfg
chmod -w -R isofiles/boot/grub/grub.cfg

cd isofiles/
chmod a+w md5sum.txt
md5sum `find -follow -type f` > md5sum.txt
chmod a-w md5sum.txt

cd ..
chmod a+w isofiles/isolinux/isolinux.bin
genisoimage -r -J -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o moojid.iso isofiles
