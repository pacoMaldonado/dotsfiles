# Guía Completa de Ghostty — Uso Diario y Personalización

> **Referencia:** Configuración basada en [Gentleman.Dots](https://github.com/Gentleman-Programming/Gentleman.Dots) y adaptada a **Linux (Fedora / Ubuntu / Linux Mint)**.

---

## 1. Atajos de Teclado para tu Día a Día

Diseñamos los atajos pensando en **ergonomía para Linux**: tu pulgar izquierdo descansa sobre la tecla **`Alt`** y con la misma mano izquierda alcanzas las teclas principales usando **solo 2 teclas** (sin estiramientos ni combinaciones incómodas de 3 teclas).

### Copiar, Pegar y Utilidades Rápidas (Mano Izquierda)

| Atajo | Acción | Descripción |
| :--- | :--- | :--- |
| **`Alt + c`** | **Copiar** | Copia el texto seleccionado al portapapeles (reemplaza el incómodo `Ctrl+Shift+C`). |
| **`Alt + p`** | **Pegar** | Pega el contenido del portapapeles (reemplaza `Ctrl+Shift+V`). |
| **`Alt + x`** | **Limpiar pantalla** | Limpia toda la terminal inmediatamente (reemplazo ergonómico del `Cmd+K` de Mac). |
| **`Alt + r`** | **Recargar config** | Aplica al instante cualquier cambio que hagas en `ghostty/config` (temas, shaders, fuentes) sin cerrar la terminal. |
| **`Alt + w`** | **Cerrar panel / tab** | Cierra el panel dividido o la pestaña actual sin pedir confirmación. |
| **`Alt + t`** | **Nueva pestaña** | Abre una nueva pestaña (aunque la barra superior esté oculta, puedes cambiar entre pestañas con `Ctrl+Tab`). |
| **`Alt + s`** | **Enviar output a Neovim** | Escribe `nvim ` (con espacio al final) y presiona `Alt + s`: guarda todo el texto visible de la terminal en un archivo temporal y lo pega para abrirlo en Neovim. |

*(Nota: Los atajos clásicos de Linux `Ctrl+Shift+C` y `Ctrl+Shift+V` siguen funcionando normalmente por si los usas por memoria muscular).*

### Manejo de Paneles Divididos (Splits estilo Vim)

| Atajo | Acción |
| :--- | :--- |
| **`Alt + v`** | Divide la terminal **a la derecha** (Vertical). |
| **`Alt + d`** | Divide la terminal **abajo** (Horizontal). |
| **`Alt + h`** | Moverse al panel de la **izquierda**. |
| **`Alt + j`** | Moverse al panel de **abajo**. |
| **`Alt + k`** | Moverse al panel de **arriba**. |
| **`Alt + l`** | Moverse al panel de la **derecha**. |
| **`Alt + f`** | **Zoom (Maximizar / Restaurar)** el panel actual temporalmente sin perder los demás paneles. |
| **`Ctrl + Shift + h/j/k/l`** | Redimensionar el tamaño del panel actual (10 píxeles por pulsación). |

---

## 2. Cómo Probar y Cambiar los Efectos Visuales (Shaders)

Tienes **51 efectos `.glsl`** copiados dentro de la carpeta [`ghostty/shaders/`](./shaders/).

### ¿Cómo probarlos en vivo?
1. Abre el archivo [`ghostty/config`](./config) en la sección **4. EFECTOS VISUALES / SHADERS**.
2. Pon un `#` al inicio del shader actual y quítale el `#` al que quieras probar:
   ```ini
   # custom-shader = shaders/cursor_smear_gentleman.glsl
   custom-shader = shaders/cursor_smear_rainbow.glsl
   ```
3. Guarda el archivo y presiona **`Alt + r`** en Ghostty. ¡El efecto cambiará al instante!
4. *(Tip)* También puedes combinar **dos shaders al mismo tiempo** dejando dos líneas `custom-shader = ...` sin comentar (por ejemplo, una estela de cursor + un efecto `bloom.glsl`).

### Catálogo de los 51 Shaders incluidos en `./shaders/`

#### A. Efectos de Estela del Cursor (Ideales para programar a diario)
- `cursor_smear_gentleman.glsl` *(Activo por defecto)*: Estela suave adaptada al color del tema.
- `cursor_smear.glsl`: Estela clásica de movimiento del cursor.
- `cursor_smear_fade.glsl`: Estela con desvanecimiento rápido.
- `cursor_smear_glow.glsl`: Estela con brillo neón alrededor del cursor.
- `cursor_smear_gradient.glsl`: Estela con degradado de color.
- `cursor_smear_rainbow.glsl`: Estela arcoíris al mover el cursor.
- `cursor_blaze.glsl` / `cursor_blaze_2.glsl`: Destello energético en cada salto del cursor.
- `cursor_blaze_tapered.glsl`: Estela afilada tipo cometa.
- `cursor_blaze_no_trail.glsl`: Pulso en el cursor sin cola de arrastre.
- `cursor_frozen.glsl`: Efecto de escarcha/hielo en el cursor.
- `cursor_border_1.glsl`: Resalta únicamente los bordes del cursor.

#### B. Efectos de Chispas, Fuego y Acción al Escribir
- `blaze_sparks.glsl`: Suelta chispas brillantes cuando el cursor se mueve rápido.
- `sparks.glsl` / `sparks-from-fire.glsl`: Partículas de fuego al mover el cursor.
- `party_sparks.glsl`: Chispas multicolores.
- `manga_slash.glsl`: Corte estilo anime/manga al saltar con el cursor.
- `fireworks.glsl` / `fireworks-rockets.glsl`: Fuegos artificiales de fondo.

#### C. Efectos de Monitor Retro / CRT / Brillo
- `bloom.glsl`: Efecto de resplandor neón suave sobre las letras (se ve increíble con temas oscuros).
- `bettercrt.glsl` / `crt.glsl` / `in-game-crt.glsl`: Simula un monitor curvo antiguo con líneas de escaneo (scanlines).
- `retro-terminal.glsl` / `tft.glsl` / `dither.glsl`: Textura de pantalla retro.

#### D. Fondos Animados y Experimentales
- `starfield.glsl` / `starfield-colors.glsl`: Viaje por estrellas en el fondo de la terminal.
- `galaxy.glsl`: Nebulosa espacial animada de fondo.
- `just-snow.glsl`: Nieve cayendo suavemente en la terminal.
- `inside-the-matrix.glsl` / `matrix-hallway.glsl`: Lluvia de código estilo Matrix.
- `cineShader-Lava.glsl` / `underwater.glsl` / `water.glsl` / `smoke-and-ghost.glsl` / `animated-gradient-shader.glsl` / `gradient-background.glsl` / `cubes.glsl` / `gears-and-belts.glsl` / `spotlight.glsl`: Efectos ambientales y de distorsión (`glitchy.glsl`, `drunkard.glsl`, `shake.glsl`, `negative.glsl`, `mnoise.glsl`, `sin-interference.glsl`, `glow-rgbsplit-twitchy.glsl`).

---

## 3. Cómo Cambiar y Probar Temas de Color

Tienes **dos formas** de cambiar los colores en [`ghostty/config`](./config) (Sección **6. TEMAS DE COLOR**):

### Opción 1: Usar tus archivos en `./themes/`
En la carpeta [`ghostty/themes/`](./themes/) tienes guardados:
- [`gentleman.conf`](./themes/gentleman.conf) *(Tema azul profundo de Gentleman.Dots — activo por defecto)*
- [`catppuccin-mocha.conf`](./themes/catppuccin-mocha.conf) *(Tema Catppuccin Mocha)*

Para activar `catppuccin-mocha.conf`, en [`ghostty/config`](./config) descomenta:
```ini
theme = catppuccin-mocha.conf
```
*(Y comenta el bloque de colores manuales de abajo si quieres que el tema controle todos los colores)*. Luego presiona **`Alt + r`**.

### Opción 2: Explorar los +300 temas integrados en Ghostty con vista previa interactiva
Ghostty incluye más de 300 temas listos para usar. Si ejecutas este comando en tu terminal:
```bash
ghostty +list-themes
```
Se abrirá un **selector interactivo** donde puedes bajar con las flechas `↑`/`↓` (o `j`/`k`) para ver en tiempo real cómo se ve cada tema (`TokyoNight`, `Kanagawa Wave`, `Gruvbox Dark`, `Rose Pine`, `Dracula`, `Nord`, etc.). Cuando encuentres uno que te guste, solo pon su nombre en [`ghostty/config`](./config):
```ini
theme = TokyoNight
```
y presiona **`Alt + r`**.

---

## 4. Cómo Cambiar entre tus Fuentes (JetBrainsMono / FiraCode)

En la sección **1. TIPOGRAFÍA** de [`ghostty/config`](./config):
```ini
font-family = JetBrainsMono Nerd Font
# font-family = FiraCode Nerd Font
font-size = 14
```
Solo comenta una y descomenta la otra, guarda y presiona **`Alt + r`**.

---

## 5. Comandos Oficiales para Descubrir Opciones de Ghostty

Cuando quieras investigar qué otros comandos, acciones o configuraciones existen en Ghostty sin tener que buscar en internet, ejecuta cualquiera de estos comandos en tu terminal:

| Comando | Para qué sirve |
| :--- | :--- |
| `ghostty +list-actions` | Muestra **todas las acciones existentes** que puedes asignar a un `keybind = ...` (por ejemplo: `new_split`, `copy_to_clipboard`, `reload_config`, etc.). |
| `ghostty +list-keybinds` | Muestra todos los atajos de teclado activos actualmente (tanto los tuyos como los predeterminados). |
| `ghostty +list-themes` | Abre el visor interactivo con todos los temas de color disponibles. |
| `ghostty +list-fonts` | Lista todas las fuentes instaladas en tu Linux que Ghostty detecta. |
| `ghostty +show-config --docs` | Muestra **todas las opciones de configuración posibles** en Ghostty con su explicación oficial. |
| `ghostty +validate-config` | Verifica que tu archivo `config` no tenga ningún error de sintaxis. |
