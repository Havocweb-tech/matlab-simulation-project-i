#!/bin/bash


battery_percentage=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep "percentage:" | awk '{print $2}' | tr -d '%')
echo $battery_percentage
# this assumes that the system is running on linux...
# Also that the battery percentage is expose in the normal way as a linux device...