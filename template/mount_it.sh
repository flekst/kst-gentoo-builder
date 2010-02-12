#!/bin/bash
source ./fs.conf
#echo $MASTER_SQUASH
if [ -z "$MASTER_SQUASH" ] \
    || [ -z "$COMMON_DIR" ] \
    || [ -z "$COMMON_DIR_MOUNTPOINT" ] ; then
    echo "Configure ./fs.conf, please"
    exit
fi
    #master
    echo "mount master squash"
    mount -o loop -t squashfs "$MASTER_SQUASH" "$WORK_DIR"
    #master + delta
    echo "mount master squash + delta via aufs"
    mount -t aufs none -o "br:$WORK_DIR_DELTA/=rw:$WORK_DIR/=ro"  "$WORK_DIR"

    echo "mount common dir"
    #common + delta -> master.common
    if ! [ -d  "$WORK_DIR$COMMON_DIR_MOUNTPOINT" ] ; then
        mkdir -p "$WORK_DIR$COMMON_DIR_MOUNTPOINT"
    fi
    mount -t aufs none \
    -o "br:$COMMON_DIR_DELTA/=rw:$COMMON_DIR=ro"\
    "$WORK_DIR$COMMON_DIR_MOUNTPOINT"

    #dev & proc
    echo "mount proc & dev"
    mount -t proc none 	"$WORK_DIR/proc"
    mount -o bind /dev/ "$WORK_DIR/dev"
