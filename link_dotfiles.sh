#!/bin/bash

# Directorio donde se encuentra este repositorio
DOTFILES_DIR="$HOME/Bully-ye"
CONFIG_DIR="$HOME/.config"

# Colores para una salida más bonita
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}Iniciando la creación de enlaces simbólicos (túneles) para Bully-ye...${NC}"

# Nos aseguramos de que ~/.config exista
mkdir -p "$CONFIG_DIR"

# Función para respaldar y enlazar
create_symlink() {
    local source_path="$1"
    local target_path="$2"

    # Si ya es el enlace correcto, no hacer nada
    if [ -L "$target_path" ] && [ "$(readlink -f "$target_path")" = "$source_path" ]; then
        echo -e "${GREEN}[OK]${NC} $target_path ya apunta a $source_path"
        return
    fi

    # Si existe una carpeta o archivo real, hacer backup
    if [ -e "$target_path" ] || [ -L "$target_path" ]; then
        echo -e "${YELLOW}[Backup]${NC} Moviendo $target_path existente a ${target_path}.bak"
        rm -rf "${target_path}.bak" 2>/dev/null
        mv "$target_path" "${target_path}.bak"
    fi

    # Crear el enlace
    ln -sf "$source_path" "$target_path"
    echo -e "${GREEN}[Enlace creado]${NC} $target_path -> $source_path"
}

echo -e "\n${BLUE}--- Directorios en ~/.config ---${NC}"
for config in hypr waybar kitty nvim cava eww matugen rofi swaync networkmanager-dmenu; do
    if [ -e "$DOTFILES_DIR/$config" ]; then
        create_symlink "$DOTFILES_DIR/$config" "$CONFIG_DIR/$config"
    else
        echo -e "${RED}[Falta]${NC} No se encontró $DOTFILES_DIR/$config"
    fi
done

echo -e "\n${BLUE}--- Archivos y shells en el Home (~/) ---${NC}"
create_symlink "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"

if [ -f "$DOTFILES_DIR/zsh/zshrc" ]; then
    create_symlink "$DOTFILES_DIR/zsh/zshrc" "$HOME/.zshrc"
else
    # Por si se usa toda la carpeta
    create_symlink "$DOTFILES_DIR/zsh" "$CONFIG_DIR/zsh"
fi

echo -e "\n${BLUE}--- Archivos de KDE / Dolphin ---${NC}"
create_symlink "$DOTFILES_DIR/dolphin/kdeglobals" "$CONFIG_DIR/kdeglobals"
create_symlink "$DOTFILES_DIR/dolphin/dolphinrc" "$CONFIG_DIR/dolphinrc"

echo -e "\n${BLUE}--- Spicetify ---${NC}"
mkdir -p "$CONFIG_DIR/spicetify/Themes"
create_symlink "$DOTFILES_DIR/spicetify_theme" "$CONFIG_DIR/spicetify/Themes/cyber"

# Aplicar el tema si spicetify está instalado
if command -v spicetify &> /dev/null; then
    echo -e "${YELLOW}Configurando tema cyber en Spicetify...${NC}"
    spicetify config current_theme cyber
    spicetify config color_scheme cyber
    echo -e "${GREEN}Configuración de Spicetify actualizada. Recuerda ejecutar 'spicetify backup apply' si es la primera vez.${NC}"
else
    echo -e "${RED}[Advertencia]${NC} spicetify no está instalado. Instálalo para aplicar el tema de Spotify."
fi

echo -e "\n${YELLOW}--- SDDM y Plymouth ---${NC}"
echo -e "Estos requieren privilegios de administrador (sudo) para instalarse en el sistema."
echo -e "Si deseas instalarlos, puedes correr manualmente:"
echo -e "  sudo cp -r $DOTFILES_DIR/sddm /usr/share/sddm/themes/TuTema"
echo -e "  sudo cp -r $DOTFILES_DIR/plymouth /usr/share/plymouth/themes/TuTema"

echo -e "\n${GREEN}¡Túneles (enlaces simbólicos) creados con éxito!${NC}"
