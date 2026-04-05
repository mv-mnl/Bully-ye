# Wallpaper Carousel (Cover Flow)

Un selector de fondos de pantalla animado en 3D tipo "Cover Flow" adaptado para funcionar de forma nativa en entornos Wayland (como Hyprland) usando `quickshell` de forma individual. Este proyecto está basado en el trabajo de ilyamiro (NixOS Config) y motor-dev (DankMaterialShell).

## 📦 Dependencias

Para que este carrusel funcione, necesitas tener instalados los siguientes paquetes en tu sistema (si usas Arch Linux):

```bash
yay -S quickshell-git qt6-declarative imagemagick waypaper
```

- **quickshell:** El motor gráfico que renderiza la pantalla sobre Wayland.
- **qt6-declarative:** Intérprete para los archivos QML.
- **imagemagick (magick o convert):** Para optimizar la resolución de las miniaturas.
- **waypaper:** Para establecer y guardar la configuración permanente de tu fondo de pantalla seleccionado.

## 🚀 Uso

Asegúrate de que tus fondos estén guardados dentro del directorio estándar de imágenes (por ejemplo, `~/Pictures/` o `~/Imágenes/`).

Ejecuta el script incluido o asígnalo mediante un atajo de teclado o botón en Waybar:
```bash
~/Bully-ye/wallpaper-carousel/run-carousel.sh
```

### 🎮 Controles
- **Flecha Izquierda / Flecha Derecha:** Navega a través del carrusel de imágenes.
- **Enter:** Aplica el fondo de pantalla actual y actualiza la configuración en el sistema a través de Waypaper.
- **Escape:** Cierra la ventana del carrusel.

## 🛠️ Personalización e Invocación

Actualmente el atajo en Waybar está configurado para invocar este proyecto. Para usar un atajo de teclado global en Hyprland, simplemente añade esto a tu `keybinds.conf` o `hyprland.conf`:
```ini
bind = SUPER SHIFT, W, exec, ~/Bully-ye/wallpaper-carousel/run-carousel.sh
```
