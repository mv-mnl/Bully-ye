#!/bin/bash

cd "$(dirname "$0")"

# Create venv if not exists
if [ ! -d "venv" ]; then
    echo "Creando entorno virtual para la app nativa aislada..."
    python3 -m venv venv
fi

# Activate venv
source venv/bin/activate

# Install requirements quietly
echo "Instalando PyQt6 (sin afectar el sistema local)..."
pip install --quiet PyQt6

# Run the app
echo "Lanzando Calculadora..."
python main.py
