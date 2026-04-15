#!/bin/bash

# Rutas relativas al directorio de configuración de Hyprland
HYPR_DIR="$HOME/Bully-ye/hypr"
TARGET_FILE=""

# Detectar el tipo de chasis
CHASSIS=$(cat /sys/class/dmi/id/chassis_type)

# 9, 10, 31, 32 suelen ser laptops (notebook, laptop, convertible, etc.)
if [[ "$CHASSIS" == "9" || "$CHASSIS" == "10" || "$CHASSIS" == "31" || "$CHASSIS" == "32" ]]; then
    TARGET_FILE="$HYPR_DIR/laptop.conf"
    echo "Detección: Laptop encontrada."
else
    TARGET_FILE="$HYPR_DIR/desktop.conf"
    echo "Detección: Desktop encontrada."
fi

# Crear o actualizar el enlace simbólico 'machine.conf'
ln -sf "$TARGET_FILE" "$HYPR_DIR/machine.conf"