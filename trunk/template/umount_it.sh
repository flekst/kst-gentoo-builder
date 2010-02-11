#!/bin/bash
source ./fs.conf
umount ./work/dev
umount ./work/proc
umount ./work${WORK_COMMON_MOUNTPOINT}
umount ./work
umount ./common
umount ./master
