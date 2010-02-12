#!/bin/bash
source ./fs.conf
modprobe loop
modprobe aufs
./mount_it.sh
chroot $WORK_DIR $CHROOT_SHELL
./umount_it.sh