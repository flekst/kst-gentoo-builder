#!/bin/bash
modprobe loop
modprobe aufs
./mount_it.sh
chroot ./work /bin/bash
./umount_it.sh