#!/bin/bash

# SHELL=/bin/bash 
# PATH=/bin:/sbin:/usr/bin:/usr/sbin
# DISPLAY=:0
# XAUTHORITY=/home/petiole/.Xauthority
# XDG_RUNTIME_DIR=/run/user/1000
# # change this to match the appropriate environment variable
# DBUS_SESSION_BUS_ADDRESS='<change with appropriate value>'
# # ^ this value is whatever is outputted by `echo $DBUS_SESSION_BUS_ADDRESS`
# 
# */1 * * * * /home/petiole/.local/bin/check-batt.sh

BATTERY_DEVICE="BAT1";
REALLY_LOW_BAT=10; # warn the user that the battery is *really* low
LOW_BAT=15; # warn the user that the battery is low, a percentage

SHUTDOWN_DELAY=10; # in minutes

remaining_charge=`cat /sys/class/power_supply/$BATTERY_DEVICE/capacity`;

cat /sys/class/power_supply/$BATTERY_DEVICE/status | grep "Discharging" > /dev/null
battery_discharge=$?;

if [[ $battery_discharge -ne 0 ]]; then
  shutdown --show
  if [[ $? -eq 0 ]]; then
    echo "[`date`] Found future shutdown command, cancelling...";
    shutdown -c --no-wall;
  fi

  echo "[`date`] battery is charging";
  exit 0;
fi;

if [[ $remaining_charge -lt $REALLY_LOW_BAT ]]; then
  notify-send -u critical "Battery Really Low!" "Charge your device immediately ($remaining_charge% remaining)\nShutting down in $SHUTDOWN_DELAY minutes";
  shutdown -h $SHUTDOWN_DELAY --no-wall;
  exit 0;
fi

if [[ $remaining_charge -lt $LOW_BAT ]]; then
  notify-send "Battery Low!" "Charge your device ($remaining_charge% remaining)";
  exit 0;
fi

echo "[`date`] battery is okay";
