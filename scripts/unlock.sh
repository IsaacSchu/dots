#!/bin/sh

sudo cryptsetup open /dev/sdb1 meg --key-file /home/lain/.keys/gura.jpg &&
    sudo mount /dev/mapper/meg /mnt/external
#    sudo mount /dev/nvme0n1p3 /mnt/windows
