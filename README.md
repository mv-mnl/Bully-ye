# Dotfiles (Bully-ye)

Bienvenido a la colección de configuraciones (dotfiles) de mi entorno en Linux. Este repositorio aloja las preferencias personalizadas para mi administrador de ventanas y utilidades asociadas, pensado principalmente para trabajar con un sistema visual avanzado.

## 🗂️ Estructura del Proyecto

El repositorio está ordenado en directorios independientes para cada herramienta. Puedes entrar en cada carpeta para entender a detalle qué hace su configuración:

- 🎨 **[hypr/](./hypr/)**: Configuración modular del compositor gráfico y de ventanas (Hyprland).
- 📊 **[waybar/](./waybar/)**: Barra de estado principal (módulos, diseño CSS).
- ⌨️ **[kitty/](./kitty/)**: Emulador de terminal acelerado por hardware, veloz y personalizable.
- 📝 **[nvim/](./nvim/)**: Editor de código y texto principal (Neovim).
- 🎵 **[cava/](./cava/)**: Visualizador de espectro de audio basado en el terminal.

Existen también otros archivos relevantes en el nivel principal del proyecto:
- `.bashrc`: Variables de consola y alias del intérprete de comandos bash.
- `rofi`: Archivo o configuración del lanzador de aplicaciones (Rofi).
- `swaync`: Archivos para el centro de control de notificaciones en pantalla.


1. 📂 Scripts (El "Pegamento" de tu Sistema)

Crea una carpeta scripts. Aquí es donde vive la verdadera magia.

    Para qué sirve: Para automatizar cosas. Por ejemplo, un script que al presionar una tecla:

        Cambie el fondo de pantalla.

        Ejecute Matugen para sacar los colores.

        Recargue Waybar y Pywal/Matugen en la terminal.

    Enlace: ln -s ~/Bully-ye/scripts ~/.config/scripts

2. 🎨 Wallpapers (Tu Galería Curada)

No dejes los fondos de pantalla regados en Downloads.

    Para qué sirve: Para que Waypaper o tu script de inicio siempre sepan dónde buscar. Si los tienes en Bully-ye/wallpapers, cuando copies tu carpeta a otra PC, ¡tus fondos favoritos se van contigo!

    Enlace: ln -s ~/Bully-ye/wallpapers ~/Pictures/Wallpapers

3. 🖱️ Cursors & Icons (La coherencia visual)

A veces el cursor de "X11" feo arruina la estética.

    Para qué sirve: Para forzar que todo el sistema use, por ejemplo, los cursores Bibata o iconos Papirus-Dark que combinen con tu tema oscuro.

    Enlace: ln -s ~/Bully-ye/icons ~/.icons y ln -s ~/Bully-ye/themes ~/.themes

4. 🌐 Browser (Firefox / Chrome)

Como usas Firefox y Chrome, podrías agregar una carpeta de personalización.

    CSS Personalizado: Existe algo llamado Firefox CSS (userChrome.css) que hace que Firefox no tenga barras de pestañas arriba y se vea ultra minimalista, integrándose con Hyprland.

5. 🎸 Spicetify (Si usas Spotify)

Ya que tienes la carpeta de Spotify en .config, podrías agregar Spicetify.

    Para qué sirve: Te permite cambiarle el tema a la aplicación de Spotify para que use los mismos colores de Matugen. Es el nivel máximo de obsesión estética.
