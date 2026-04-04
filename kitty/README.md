# 🐱 Kitty Terminal Configuration

¡Bienvenido a la configuración hiper-modular y súper vitaminada de Kitty!
Esta terminal aprovecha la aceleración por GPU para ser una de las más rápidas del mundo, y la hemos estructurado para que vuele como si fuera **Tmux**, manejable 100% por teclado, ligera y ordenada.

## 📂 Arquitectura Modular

La principal ventaja de esto es que en un sistema normal todo estaría mezclado en un monstruoso archivo de mil líneas. Nosotros lo separamos elegantemente:

- 🧱 **`kitty.conf`**: El enrutador. Su único trabajo es cargar los sub-módulos.
- 🖋️ **`fonts.conf`**: Todo lo relacionado a la tipografía (*JetBrainsMono Nerd Font*), tamaños, ligaduras e incluso la forma y animación del cursor (*beam* parpadeante).
- 🪟 **`window.conf`**: Configuración física de la ventana. Su transparencia (opacidad total para Hyprland), sus bordes y... donde se habitan los valiosos **Layouts** `splits`.
- 🏷️ **`tabs.conf`**: Diseño exclusivo para la barra de pestañas (Tab Bar), configurado para verse agresivo como *Powerline* en la zona base de tu pantalla.
- ⚙️ **`behavior.conf`**: Comportamientos puros ("Under the hood"). Memoria enorme de *Scrollback*, copiado inteligente, y silenciadores de ruidos.
- 🎨 **`teme.conf`**: Tu paleta de colores. Listo para cargar las directrices de tu *Catppuccin Mocha*.
- ⌨️ **`keybinds.conf`**: La joya de la corona. Los súper atajos que convierten tu terminal en la pesadilla de cualquier *mouse-user*.

---

## 🚀 Tus Súper Atajos de Teclado (Keybinds)

Tu mano no necesita viajar más al ratón. Memorízate estos movimientos fluidos para que trabajes como en Matrix:

### Portapapeles Inteligente
El teclado puede complementar pero no es necesario: ¡Sólo de seleccionar el texto ya se copia automáticamente!
Si igual eres terco:
- `Ctrl + Shift + C` -> Copiar.
- `Ctrl + Shift + V` -> Pegar.

### Viajar por Pestañas (Tabs)
Manejate libremente con *Alt* si no te gustan las cajas divididas:
- `Alt + T` -> Despliega una nueva pestaña infinita.
- `Alt + W` -> Mátala (Cierra tab / ventana actual).
- `Alt + ⬅️ / ➡️` -> Patínate de pestaña en pestaña (Adelante / Atrás).

### 🥷 Dominio del Layout "Splits" (Estilo Tmux)
La pantalla es tu lienzo. Párela.

**1. Cortar y Eliminar Paneles**
- `Alt + Enter` -> Clon rápido. Abre allí mismito un panel pegado (En la misma ruta en la que estabas usando el comando actual).
- `Alt + H` -> El corte ninja **H**orizontal.
- `Alt + V` -> El corte ninja **V**ertical.
- `exit` o `Ctrl + D` -> Cierra limpiamente el panel saliendo de la shell actual (el método más pro y natural).
- `Alt + W` -> Fuerza el cierre del panel / split en el que tengas el cursor en ese momento.

**2. Navegación Veloz (El Joystick)**
- `Ctrl + Flechas Arriba/Abajo/Izq/Der` -> En vez de hacer click en la ventanita para escribir, usa la flecha para enfocarte hacia esa dirección directamente.

**3. Mudanzas y Agarre**
¿El panel inferior quedó en mal lugar? No pasa nada, agárralo:
- `Shift + Flechas Arriba/Abajo/Izq/Der` -> Teletransporta u obliga a la ventana actual a ocupar el cuadro superior/inferior, y permuta su posición.

**4. Arquitectura de Espacio (Redimensionar)**
¿Quieres la consola derecha más delgada?
- `Alt + Shift + Flechas` -> Empuja los bordes de la pared de tu ventana seleccionada. Ampliándola o reduciéndola.
- `Alt + Home (Inicio)` -> ¿Te arrepentiste e hiciste un caos con los tamaños? Esto vuelve a acomodarlos para que sean partes iguales.

---

## 👨‍💻 Tip del Día

Kitty tiene *Hot-Reloading* incorporado. Si entras un momento a `teme.conf` o `fonts.conf`, editas un código y lo guardas, sólo tienes que oprimir en la propia terminal de Kitty:

- **`Ctrl + Shift + F5`**

¡Pá! Configuraciones recargadas al instante en todos tus paneles abiertos.
Dale duro y que el código fluya.
