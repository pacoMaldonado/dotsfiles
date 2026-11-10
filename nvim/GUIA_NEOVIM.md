# Guía Completa de Neovim — Uso Diario, IA, Plugins y Personalización

> **Referencia:** Configuración basada en [Gentleman.Dots (`GentlemanNvim`)](https://github.com/Gentleman-Programming/Gentleman.Dots) sobre [LazyVim](https://www.lazyvim.org/), adaptada para **Python (`pyenv`), Node.js (`fnm`), Claude Code, Antigravity CLI (`agy`) y AWS Kiro CLI (`kiro-cli`)**.

---

## 1. Tus Asistentes de Inteligencia Artificial en Neovim (`Espacio + a`)

Eliminamos el antiguo plugin `gemini-cli.nvim` (que daba error al abrir Neovim porque buscaba el binario viejo `gemini`) y quitamos `avante.nvim`, `codecompanion.nvim` y `copilot` que no utilizas.

En su lugar, configuramos integración directa para las **3 herramientas de IA que tienes instaladas** (`claude`, `agy`, `kiro-cli`) en [`lua/plugins/claude-code.lua`](./lua/plugins/claude-code.lua) y [`lua/plugins/ai-cli.lua`](./lua/plugins/ai-cli.lua):

| Atajo (`Espacio` = `<leader>`) | Herramienta | Acción |
| :--- | :--- | :--- |
| **`Espacio + a + c`** | **Claude Code (`claude`)** | Abre u oculta el panel lateral de Claude Code. |
| **`Espacio + a + g`** | **Antigravity CLI (`agy`)** | Abre u oculta el panel lateral interactivo de **Antigravity CLI** en la raíz de tu proyecto. |
| **`Espacio + a + k`** | **AWS Kiro CLI (`kiro-cli`)** | Abre u oculta el panel lateral interactivo de **Kiro CLI** en la raíz de tu proyecto. |

### Atajos adicionales específicos de Claude Code (`claude-code.lua`)
- **`Espacio + a + b`**: Envía el archivo actual (`buffer`) al contexto de Claude.
- **`Espacio + a + s`** *(en modo Visual)*: Envía el bloque de código seleccionado a Claude.
- **`Espacio + a + a`**: Acepta los cambios propuestos por Claude (*Accept Diff*).
- **`Espacio + a + d`**: Rechaza los cambios propuestos por Claude (*Deny Diff*).
- **`Espacio + a + r`**: Reanuda una conversación anterior (`--resume`).
- **`Espacio + a + m`**: Cambia el modelo de Claude.

### ¿Cómo activar `OpenCode` en el futuro?
El archivo [`lua/plugins/opencode.lua`](./lua/plugins/opencode.lua) ya quedó configurado y guardado. Cuando quieras empezar a usarlo:
1. Abre [`lua/plugins/disabled.lua`](./lua/plugins/disabled.lua).
2. Cambia `"NickvanDyke/opencode.nvim", enabled = false` a **`enabled = true`**.

---

## 2. Exploración de Archivos y Búsqueda Rápida

### A. `oil.nvim` (Editar carpetas como si fueran un archivo de texto)
Configurado en [`lua/plugins/oil.lua`](./lua/plugins/oil.lua). Es la forma más rápida de crear, renombrar o borrar archivos:
- **`-` (Guion)**: Abre la carpeta donde está tu archivo actual.
- **`Espacio + E`**: Abre `Oil` en una ventana flotante en el centro.
- **Dentro de Oil:**
  - `Enter`: Entra a una carpeta o abre el archivo bajo el cursor.
  - `-`: Sube a la carpeta padre.
  - **Crear archivo/carpeta:** Escribe una nueva línea con el nombre (si termina en `/`, crea una carpeta) y presiona **`Ctrl + s`** (o `:w`).
  - **Renombrar:** Edita el nombre de cualquier archivo en su línea y presiona **`Ctrl + s`**.
  - **Eliminar:** Borra la línea con `dd` y presiona **`Ctrl + s`**.
  - `q`: Cierra la ventana de Oil.

### B. Buscador Ultrarrápido (`Snacks Picker` / `fzf-lua`)
- **`Espacio + f + f`**: Buscar archivos por nombre en todo el proyecto.
- **`Espacio + s + g`** *(Modo Normal)*: Buscar texto en vivo (*Live Grep*) en todos los archivos del proyecto.
- **`Espacio + s + g`** *(Modo Visual)*: Selecciona cualquier palabra o frase y presiona `Espacio + sg` para buscar exactamente ese texto en el proyecto.
- **`Espacio + f + b`**: Ver y cambiar entre los archivos que tienes abiertos (*Buffers*).
- **`Espacio + b + q`**: Cierra todos los archivos abiertos excepto el que estás viendo ahora mismo.

### C. `Harpoon 2` (Saltar al instante entre tus archivos más usados)
- **`Espacio + H`**: Agrega el archivo actual a tu lista rápida de Harpoon.
- **`Espacio + h`**: Abre el menú de archivos marcados en Harpoon.
- **`Espacio + 1 / 2 / 3 / 4`**: Salta instantáneamente al archivo 1, 2, 3 o 4 de tu lista.

---

## 3. Edición Avanzada y Navegación de Código (LSP)

### Vistas Previas Flotantes (`goto-preview` en `lua/plugins/editor.lua`)
En lugar de perderte saltando de archivo en archivo, puedes ver la definición en una ventana flotante sobre tu código:
- **`gpd`**: Abre una ventana flotante con la **definición** de la función o variable bajo el cursor.
- **`gpr`**: Abre una ventana flotante con todas las **referencias** (dónde se usa esa función).
- **`gpi`**: Vista previa de la **implementación**.
- **`gpy`**: Vista previa de la **definición de tipo** (TypeScript / Python types).
- **`gP`** *(P mayúscula)*: **Cierra todas** las ventanas flotantes de vista previa.

### Otros Atajos de Edición Muy Útiles
- **`Ctrl + s`** *(Modo Normal)*: Guarda el archivo actual mostrando notificación `Saved!`.
- **`Espacio + c + s`**: Abre/oculta el árbol de símbolos del archivo (`SymbolsOutline`: funciones, clases, variables).
- **`Espacio + f + s`**: Abre **`rip-substitute`** (buscar y reemplazar con expresiones regulares usando `ripgrep` y vista previa en vivo).
- **`Ctrl + n`** (`vim-multiple-cursors`): Selecciona la palabra bajo el cursor; cada vez que presionas `Ctrl + n` agrega otro cursor en la siguiente coincidencia para editarlas todas al mismo tiempo.

---

## 4. Plugins Especiales / De Nicho Incluidos y Cómo Usarlos

Conservamos todos los plugins interesantes y corregimos su configuración para que no den errores:

### 1. `obsidian.nvim` ([`lua/plugins/obsidian.lua`](./lua/plugins/obsidian.lua))
Convierte Neovim en un gestor de notas Markdown conectado a `~/.config/obsidian` (la carpeta se crea sola automáticamente):
- **`Espacio + o + n`**: Crear una nueva nota (`:Obsidian new`).
- **`Espacio + o + s`**: Buscar dentro de tus notas (`:Obsidian search`).
- **`Espacio + o + q`**: Cambiar rápido entre notas (`:Obsidian quick_switch`).
- **`Espacio + o + c`**: Marcar / desmarcar una casilla de tarea `[x]` (`:Obsidian check`).
- **`Espacio + o + b`**: Ver qué otras notas enlazan a la nota actual (`:Obsidian backlinks`).

### 2. `screenkey.nvim` ([`lua/plugins/screenkey.lua`](./lua/plugins/screenkey.lua))
Muestra en una ventana flotante las teclas exactas que vas presionando (ideal si compartes pantalla o grabas un video):
- **`Espacio + u + k`**: Activa o desactiva `Screenkey`.

### 3. `vim-be-good` ([`lua/plugins/vim-be-good.lua`](./lua/plugins/vim-be-good.lua))
Minijuego creado por *ThePrimeagen* para entrenar tu velocidad y memoria muscular con movimientos de Vim:
- Ejecuta **`:VimBeGood`** y presiona `Enter` para elegir el modo de entrenamiento.

### 4. `zen-mode.nvim` + `twilight.nvim` ([`lua/plugins/ui.lua`](./lua/plugins/ui.lua))
Modo de concentración total (centra el código y atenúa los bloques que no estás editando):
- **`Espacio + z`**: Activa o sale del Modo Zen (`:ZenMode`).

### 5. `veil.nvim` ([`lua/plugins/veil.lua`](./lua/plugins/veil.lua))
Oculta automáticamente con asteriscos los valores secretos cuando abres un archivo `.env` para que nadie vea tus contraseñas o API keys en pantalla.

### 6. `precognition.nvim` ([`lua/plugins/precognition.lua`](./lua/plugins/precognition.lua))
Muestra pistas visuales de a dónde saltaría el cursor con `w`, `b`, `e`, `$`, `0`. Está desactivado por defecto en [`lua/plugins/disabled.lua`](./lua/plugins/disabled.lua); cambia `enabled = true` ahí si quieres activarlo.

---

## 5. Soporte de Lenguajes (Python, Node.js/TypeScript) y Ortografía

- **Node.js con `fnm` ([`lua/config/nodejs.lua`](./lua/config/nodejs.lua)):** Detecta automáticamente tu instalación de `fnm` en `~/.local/share/fnm`. Puedes verificar qué versión de Node está usando Neovim ejecutando **`:NodeInfo`**.
- **Python con `pyenv` ([`lua/config/lazy.lua`](./lua/config/lazy.lua)):** Detecta automáticamente `~/.pyenv/shims/python3` e instala el soporte oficial de LazyVim para Python (`pyright` + `ruff`).
- **Ortografía (`spell`):** Quedó **desactivada por defecto** (`vim.opt.spell = false`) para que no subraye tu código ni tus textos en español. Si algún día quieres activarla temporalmente en un documento, presiona **`Espacio + u + s`** (configurada con soporte para español `"es"` e inglés `"en"`).

---

## 6. Cómo Cambiar de Tema de Color y Gestionar Plugins

### Cambiar Tema de Color
En [`lua/plugins/colorscheme.lua`](./lua/plugins/colorscheme.lua) tienes instalados:
- `gentleman-kanagawa-blur` *(Activo por defecto)*
- `catppuccin`
- `oldworld`
- `kanagawa`
- `tokyonight`

- **Para probarlos en vivo:** Presiona **`Espacio + u + C`** (C mayúscula) y muévete con las flechas.
- **Para dejar otro fijo:** En las últimas líneas de [`lua/plugins/colorscheme.lua`](./lua/plugins/colorscheme.lua), cambia `colorscheme = "gentleman-kanagawa-blur"` por el nombre del tema que prefieras.

### Comandos de Administración de Neovim

| Comando | Para qué sirve |
| :--- | :--- |
| **`:Lazy`** | Abre el gestor de plugins (presiona `U` para actualizar plugins o `X` para limpiar los que ya no se usen). |
| **`:LazyExtras`** | Abre el catálogo oficial de LazyVim para activar soporte de nuevos lenguajes (Go, Rust, Docker, SQL, Astro, Vue, Angular, etc.) presionando `x` sobre cualquiera. |
| **`:Mason`** | Abre el instalador de servidores LSP, linters y formateadores. |
| **`:NodeInfo`** | Muestra qué versión y ruta de Node (`fnm`) está usando Neovim. |
| **`Espacio + ?`** | Abre `Which-Key` mostrando todos los atajos disponibles en la ventana actual. |
