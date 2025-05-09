#!/bin/bash
sudo make -j14 && sudo make modules_install && sudo make install && sudo genkernel --install --kernel-config=/usr/src/linux/.config initramfs && sudo emerge nvidia-drivers && sudo emerge linux-firmware && sudo grub-mkconfig -o /boot/grub/grub.cfg && date
