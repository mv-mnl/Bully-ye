#!/bin/bash

# install.sh - Script de instalación de dependencias para los dotfiles (Bully-ye)

# Colores
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}Iniciando la instalación de dependencias para el entorno Bully-ye...${NC}"

# Detectar el manejador de paquetes AUR (yay o paru)
AUR_HELPER=""
if command -v paru &> /dev/null; then
    AUR_HELPER="paru"
elif command -v yay &> /dev/null; then
    AUR_HELPER="yay"
else
    echo -e "${RED}Ningún ayudante de AUR encontrado (yay o paru).${NC}"
    echo "Instalando yay..."
    sudo pacman -S --needed --noconfirm git base-devel
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay && makepkg -si --noconfirm
    cd - && rm -rf /tmp/yay
    AUR_HELPER="yay"
fi

# Lista de paquetes deducida de las carpetas de configuración
PACKAGES=(
    "hyprland"
    "waybar"
    "kitty"
    "neovim"
    "cava"
    "eww"
    "matugen-bin"
    "rofi-wayland"
    "swaync"
    "networkmanager-dmenu"
    "fastfetch"
    "zsh"
    "zsh-autosuggestions"
    "zsh-syntax-highlighting"
    "starship"
    "fzf"
    "zoxide"
    "eza"
    "bat"
    "fd"
    "ripgrep"
    "hyprpaper"
    "waypaper"
    "quickshell-git"
    "qt6-declarative"
    "imagemagick"
    "ttf-jetbrains-mono-nerd"
    "ttf-font-awesome"
    "ttf-inter"
    "ttf-roboto"
    "plymouth"
    "sddm"
)

echo -e "${BLUE}Paquetes a instalar:${NC} ${PACKAGES[*]}"
echo -e "${GREEN}Utilizando ${AUR_HELPER} para instalar los paquetes...${NC}"

$AUR_HELPER -S --needed "${PACKAGES[@]}"

echo -e "${GREEN}Instalación de paquetes completada.${NC}"
echo -e "Puedes ejecutar ${BLUE}./link_dotfiles.sh${NC} para enlazar tus configuraciones."
echo -e "Puedes ejecutar ${BLUE}./actu.sh${NC} para configurar sddm y plymouth."
