#!/bin/bash
testdir=/tmp/directvolume-testing

sudo umount "$testdir"/da-1 || true
sudo umount "$testdir"/da-2 || true
sudo umount "$testdir"/tmp || true

sudo losetup -d /dev/loop20 || true
sudo losetup -d /dev/loop21 || true
sudo losetup -d /dev/loop22 || true
sudo losetup -d /dev/loop23 || true

sudo rm -rf "$testdir"
