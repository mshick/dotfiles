#!/bin/sh

while getopts "p:" opt; do
    case "$opt" in
    p)  partition=$OPTARG
        ;;
    esac
done

partition=${partition:-BOOTCAMP}
amount=`/usr/sbin/diskutil list | grep $partition | wc -l`

if [ $amount = 1 ]; then
    path=`/usr/sbin/diskutil list | grep $partition | sed -e 's/^\(.*\)\(disk0s.\)$/\/dev\/\2/g'`
    chmod 777 $path
    /usr/sbin/diskutil unmount $path
fi
