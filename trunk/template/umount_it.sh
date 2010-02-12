#!/bin/bash
source ./fs.conf
#echo $MASTER_SQUASH
if [ -z $MASTER_SQUASH ] \
    || [ -z $COMMON_DIR ] \
    || [ -z $COMMON_DIR_MOUNTPOINT ] ; then
    echo Configure ./fs.conf, please

else
    echo unmounting dev
    umount $WORK_DIR/dev
    echo unmounting proc
    umount $WORK_DIR/proc
    echo unmounting common dir
    umount $WORK_DIR$COMMON_DIR_MOUNTPOINT
    echo unmounting workdir squash+aufs
    umount $WORK_DIR
    echo unmounting workdir squash
    umount $WORK_DIR
fi
