#!/usr/bin/sh

if [ $# -eq 0 ]; then
  echo "usage:        $ user-mount.sh <device>"
  echo ""
  echo "note:         mounts the chosen device to /media/usb"
  echo "example:      $ user-mount.sh /dev/sda1"
  exit 0
fi

sudo -v

if [ $? -ne 0 ]; then
  echo "missing permissions"
  exit 1
fi

dev_name=`echo $1 | rev | cut -d'/' -f1 | rev`

sudo mount $1 -o uid=1000,gid=1000 --mkdir /media/${dev_name}/

if [ $? -ne 0 ]; then
  echo "failed to mount"
  exit 1
fi

echo "[`date`] successfully mounted $1"
