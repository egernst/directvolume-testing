#!/bin/bash
set -e 
# Create two images: one unmounted (raw block volume), one mounted:

testdir=/tmp/directvolume-testing

sudo umount "$testdir"/da-1 || true
sudo umount "$testdir"/da-2 || true
sudo umount "$testdir"/tmp || true

sudo losetup -d /dev/loop20 || true
sudo losetup -d /dev/loop21 || true
sudo losetup -d /dev/loop22 || true
sudo losetup -d /dev/loop23 || true

sudo rm -rf "$testdir"
mkdir -p "$testdir"

truncate "$testdir"/disk1.img --size 4G
mkfs -t ext4 "$testdir"/disk1.img

sudo losetup /dev/loop20 "$testdir"/disk1.img

truncate "$testdir"/disk2.img --size 4G
sudo mkfs -t ext4 "$testdir"/disk2.img
sudo losetup /dev/loop21 "$testdir"/disk2.img

truncate "$testdir"/disk3.img --size 4G
sudo mkfs -t ext4 "$testdir"/disk3.img
sudo losetup /dev/loop22 "$testdir"/disk3.img

truncate "$testdir"/disk4.img --size 4G
sudo mkfs -t ext4 "$testdir"/disk4.img
sudo losetup /dev/loop23 "$testdir"/disk4.img

mkdir -p "$testdir"/da-1
mkdir -p "$testdir"/da-2
mkdir -p "$testdir"/tmp

# put test data in the block devices:
sudo mount /dev/loop22 "$testdir"/tmp
sudo cp hello1 "$testdir"/tmp/
sudo umount /dev/loop22

sudo mount /dev/loop23 "$testdir"/tmp
sudo cp hello2 "$testdir"/tmp/
sudo umount /dev/loop23

# mount the fs volumes which have direct assigned details:
sudo mount /dev/loop20 "$testdir"/da-1
sudo mount /dev/loop21 "$testdir"/da-2

sudo cp csiPlugin-1.json "$testdir"/da-1/csiPlugin.json
sudo cp csiPlugin-2.json "$testdir"/da-2/csiPlugin.json
