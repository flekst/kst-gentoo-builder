#!/bin/bash
source ./fs.conf

if [ -z "$MASTER_SQUASH" ] ; then
    echo Configure ./fs.conf, please
    exit
fi

if [ -z $1 ] ; then
    echo select filename and other parameters for new  squash-file
    echo usage: $0 /path/file-name.squash [--mksquashfs-params]
    exit
fi

    #master
    echo "mount master squash"
    mount -o loop -t squashfs "$MASTER_SQUASH" "$WORK_DIR"
    #master + delta
    echo "mount master squash + delta via aufs"
    mount -t aufs none -o "br:$WORK_DIR_DELTA/=rw:$WORK_DIR/=ro" "$WORK_DIR"

    cd "$WORK_DIR"
    mksquashfs . $@
    echo "umount master squash + delta via aufs"
    umount "$WORK_DIR"
    echo "umount master squash"
    umount "$WORK_DIR"