#!/bin/sh

# written based off https://www.linuxquestions.org/questions/linux-hardware-18/safe-removal-of-external-usb-hdd-616410/

if [ $# -eq 0 ]
then
  echo "usage:           $ safe-eject.sh <device>"
  echo ""
  echo "note:            only use this for external devices"
  echo "example:         $ safe-eject.sh /dev/sda1"
  exit 0
fi

sudo -v

if [ $? -ne 0 ]
then
  echo "[err] permission not given, exiting"
  exit 1
fi

WD=$1

if findmnt $WD; then
  echo "[info] unmounting $WD" # properly stop the heads and cylinders
  sudo umount $WD
fi
if [ $? -eq 0 ]
then
  echo "[info] stopping $WD" # properly stop the heads and cylinders
  sudo sdparm --command=stop $WD
  echo "[info] powering off $WD" # properly power off device before ejecting
  udisksctl power-off -b /dev/sdc1
  echo "[done] device $WD is now safe to eject";
  exit 0
fi

echo "[err] umount failed"
exit $?
