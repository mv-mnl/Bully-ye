#!/bin/bash

# Dentro de tu script de instalación/enlaces
MACHINE_TYPE=$(bash ~/Bully-ye/hypr/scripts/detect_machine.sh)

if [ "$MACHINE_TYPE" == "laptop" ]; then
    ln -sf ~/Bully-ye/hypr/laptop.conf ~/Bully-ye/hypr/machine.conf
else
    ln -sf ~/Bully-ye/hypr/desktop.conf ~/Bully-ye/hypr/machine.conf
fi