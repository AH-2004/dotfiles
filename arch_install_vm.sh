#!/bin/bash

# NOTE: DO NOT RUN THIS SCRIPT ON ALREADY INSTALLED ARCH SYSTEMS

# Make partitions and mount before running script

# 300mib efi
# 512mib sawp
# rest linux
# mkfs.ext4 /dev/LINUX PARTITION
# mkswap /dev/SWAP PARTITION
# mkfs.fat -F 32 /dev/EFI PARTITION 

# mount /dev/LINUX PARTITION /mnt
# swapon /dev/SWAP PARTITION
# mkdir /mnt/boot
# mount /dev/EFI PARTITION /mnt/boot

pacman -Sy --noconfirm archlinux-keyring
pacstrap /mnt base linux linux-firmware nano neofetch
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt

echo 'LANG="en_US.UTF-8"' >> /etc/locale.conf
echo 'LC_COLLATE="C"' >> /etc/locale.conf
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen

echo AH-VM > /etc/hostname
useradd -m --badname -G wheel AH
# Set password later using passwd
# Setup sudo yourself /etc/sudoers

pacman -S --noconfirm grub os-prober
grub-install --recheck --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
