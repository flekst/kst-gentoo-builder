#!/bin/bash
source ./fs.conf
#echo $MASTER_SQUASH

if [ -z $1 ] ; then
    echo select filename for new  squash-file
    exit
fi

if [ -z $MASTER_SQUASH ] \
    || [ -z $COMMON_DIR ] \
    || [ -z $WORK_COMMON_MOUNTPOINT ] ; then
    echo Configure ./fs.conf, please

else
    mount -o loop -t squashfs $MASTER_SQUASH ./master
#    mount -o bind $COMMON_DIR ./common
    mount -t aufs none -o br:./diff.work/=rw:./master/=ro ./work
#    mount -t aufs none -o br:./diff.common=rw:./common=ro ./work${WORK_COMMON_MOUNTPOINT}
#    mount -t proc none ./work/proc
#    mount -o bind /dev/ ./work/dev
    cd work
    mksquashfs . $@
    umount ./work
    umount ./master

fi
