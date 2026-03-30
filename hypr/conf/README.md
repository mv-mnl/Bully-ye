# Módulos de Configuración (`/conf`)

Esta carpeta se ocupa de centralizar las diferentes categorías del sistema, separando en archivos más pequeños las responsabilidades de personalización. 

## 📝 Lista de Componentes

La carpeta divide tu configuración en los siguientes subarchivos para facilitar la lectura:

- **[`monitors.conf`](./monitors.conf)**
  Configuración global de las pantallas. Define la resolución, tasa de refresco, y posición de cada monitor conectado.

- **[`autostart.conf`](./autostart.conf)**
  Programas o *daemons* que son obligatorios de iniciar al inicio de sesión mediante la orden `exec-once` (ej. Waybar, notificaciones, herramientas de red).

- **[`environment.conf`](./environment.conf)**
  Variables de entorno obligatorias necesarias para un correcto renderizado en sistemas Wayland, temas de cursores y soporte nativo bajo apps creadas con Qt.

- **[`input.conf`](./input.conf)**
  Dispositivos de entrada: Teclado (distribuciones de teclas), Ratón, y ajustes sensibles para tu Touchpad (por ejemplo, permitir clics al tocar, desplazamiento natural).

- **[`general.conf`](./general.conf)**
  Atributos visuales primarios: tamaño de bordes de ventana, huecos (gaps) internos y externos, y la configuración nativa de capas `dwindle`.

- **[`animations.conf`](./animations.conf)**
  Tiempos y diseño animado. En este lugar se definen las asombrosas curvas de transición de Hyprland ("curvas de Bézier").

- **[`windowrules.conf`](./windowrules.conf)**
  Comportamientos especiales y asignaciones (`windowrule` y `windowrulev2`). Aquí estableces qué ventana de ciertas apps debe ser flotante, transparente o abrirse por defecto en qué espacio de trabajo.

- **[`keybinds.conf`](./keybinds.conf)**
  Atajos del teclado del sistema operativo (donde la tecla `$mainMod` asignada es `SUPER`), atajos para aplicaciones de uso habitual, movimiento de ventanas y controles multimedia de volumen y brillo.
