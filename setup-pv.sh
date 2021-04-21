# Create two images: one unmounted (raw block volume), one mounted:
sudo truncate /home/eernst/volume-testing/disk1.img --size 4G
sudo mkfs -t ext4 /home/eernst/volume-testing/disk1.img
sudo losetup /dev/loop11 /home/eernst/volume-testing/disk1.img

sudo truncate /home/eernst/volume-testing/disk2.img --size 4G
sudo mkfs -t ext4 /home/eernst/volume-testing/disk2.img
sudo losetup /dev/loop12 /home/eernst/volume-testing/disk2.img

sudo truncate /home/eernst/volume-testing/disk3.img --size 4G
sudo mkfs -t ext4 /home/eernst/volume-testing/disk3.img
sudo losetup /dev/loop13 /home/eernst/volume-testing/disk3.img

sudo truncate /home/eernst/volume-testing/disk4.img --size 4G
sudo mkfs -t ext4 /home/eernst/volume-testing/disk4.img
sudo losetup /dev/loop14 /home/eernst/volume-testing/disk4.img

mkdir -p /home/eernst/volume-testing/da-1
mkdir -p /home/eernst/volume-testing/da-2
mkdir -p /home/eernst/volume-testing/tmp

# put test data in the block devices:
sudo mount /dev/loop13 /home/eernst/volume-testing/tmp
sudo cp hello1 tmp/
sudo umount /dev/loop13

sudo mount /dev/loop14 /home/eernst/volume-testing/tmp
sudo cp hello2 tmp/
sudo umount /dev/loop14

# mount the fs volumes which ave direct assigne details::
sudo mount /dev/loop11 /home/eernst/volume-testing/da-1
sudo mount /dev/loop12 /home/eernst/volume-testing/da-2

sudo cp csiPlugin-1.json da-1/csiPlugin.json
sudo cp csiPlugin-2.json da-2/csiPlugin.json
