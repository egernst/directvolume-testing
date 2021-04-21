# Create two images: one unmounted (raw block volume), one mounted:
sudo losetup -D /dev/loop11
sudo losetup -D /dev/loop12
sudo losetup -D /dev/loop13
sudo losetup -D /dev/loop14

sudo umount /home/eernst/volume-testing/da-1
sudo umount /home/eernst/volume-testing/da-2
sudo umount /home/eernst/volume-testing/tmp
sudo rmdir da-1
sudo rmdir da-2
sudo rmdir tmp

sudo rm /home/eernst/volume-testing/disk*
