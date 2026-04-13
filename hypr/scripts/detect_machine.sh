#!/bin/bash

if [ -d /sys/class/power_supply/BAT0 ] || [ -d /sys/class/power_supply/BAT1 ]; then
    echo "laptop"
else
    echo "desktop"
fi