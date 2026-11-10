# Guía Maestra de Neovim — IA, Obsidian, Librerías y Atajos

> **Referencia:** Configuración basada en [Gentleman.Dots (`GentlemanNvim`)](https://github.com/Gentleman-Programming/Gentleman.Dots) sobre [LazyVim](https://www.lazyvim.org/), adaptada para **Python (`pyenv`), Node.js (`fnm`), Claude Code, Antigravity CLI (`agy`), AWS Kiro CLI (`kiro-cli`) y Obsidian**.

*(Nota importante: En toda esta guía, la tecla `<leader>` es la barra **`Espacio`**).*

---

## 1. Tus Asistentes de Inteligencia Artificial (`Espacio + a`)

Configurados en [`lua/plugins/claude-code.lua`](./lua/plugins/claude-code.lua) y [`lua/plugins/ai-cli.lua`](./lua/plugins/ai-cli.lua):

| Atajo | Herramienta | Acción |
| :--- | :--- | :--- |
| **`Espacio + a + c`** | **Claude Code (`claude`)** | Abre u oculta el panel lateral de Claude Code a la izquierda. |
| **`Espacio + a + g`** | **Antigravity CLI (`agy`)** | Abre u oculta el panel lateral interactivo de **Antigravity CLI** en la raíz del proyecto. |
| **`Espacio + a + k`** | **AWS Kiro CLI (`kiro-cli`)** | Abre u oculta el panel lateral interactivo de **Kiro CLI** en la raíz del proyecto. |

### Atajos adicionales de Claude Code (`claude-code.lua`)
- **`Espacio + a + f`**: Pasa el cursor/foco a la ventana de Claude Code.
- **`Espacio + a + b`**: Agrega el archivo actual (`buffer`) al contexto de Claude.
- **`Espacio + a + s`** *(en modo Visual)*: Envía el código seleccionado a Claude.
- **`Espacio + a + s`** *(en el árbol de archivos Oil / MiniFiles)*: Agrega el archivo bajo el cursor a Claude.
- **`Espacio + a + a`**: Acepta los cambios propuestos por Claude (*Accept Diff*).
- **`Espacio + a + d`**: Rechaza los cambios propuestos por Claude (*Deny Diff*).
- **`Espacio + a + r`**: Reanuda una conversación anterior (`--resume`).
- **`Espacio + a + C`**: Continúa la última sesión (`--continue`).
- **`Espacio + a + m`**: Selecciona el modelo de Claude.

*(Para activar `OpenCode` en el futuro, abre [`lua/plugins/disabled.lua`](./lua/plugins/disabled.lua) y cambia `"NickvanDyke/opencode.nvim"` a `enabled = true`).*

---

## 2. Guía Completa de `obsidian.nvim` (Tu Segundo Cerebro en un Repo Privado)

Configurado en [`lua/plugins/obsidian.lua`](./lua/plugins/obsidian.lua). Tu bóveda apunta a **`~/Proyectos/notas`** para que puedas mantenerla en un **repositorio privado de GitHub** independiente de tus dotfiles.

### A. Cómo configurar tu Repositorio Privado de Notas (Solo una vez en GitHub)

1. Crea un repositorio **Privado** vacío en tu cuenta de GitHub llamado **`notas`** (`git@github.com:pacoMaldonado/notas.git`).
2. En tu terminal ejecuta:
   ```bash
   cd ~/Proyectos/notas
   git init
   git branch -M main
   git add .
   git commit -m "feat: iniciar boveda de notas"
   git remote add origin git@github.com:pacoMaldonado/notas.git
   git push -u origin main
   ```
3. **Uso diario en terminal:**
   - Escribe **`notas`** en cualquier terminal para ir a `~/Proyectos/notas` y abrir tus notas en Neovim.
   - Escribe **`notassync`** en cualquier terminal para subir todos tus apuntes nuevos a tu repositorio privado de GitHub con un solo comando.
   - Cuando formatees tu PC, `install.sh` clonará automáticamente `git@github.com:pacoMaldonado/notas.git` en `~/Proyectos/notas` (si tienes acceso SSH/HTTPS).

---

### B. Estructura de Carpetas de tu Bóveda (`~/Proyectos/notas`)

Neovim crea y mantiene automáticamente esta estructura dentro de `~/Proyectos/notas`:

```text
~/Proyectos/notas/
├── diarias/                    # Tus notas del día a día (Ej: 2026-11-10.md)
├── proyectos/                  # Apuntes por proyecto o cliente
├── templates/                  # Plantillas reutilizables
│   └── nota-tecnica.md         # Plantilla base autogenerada
└── comandos-de-docker.md       # Notas generales en la raíz (o en subcarpetas)
```

---

### C. Cómo Nombrar Archivos y Crear Notas

1. **Creación desde cualquier proyecto (`Espacio + o + n`):**
   - Estés programando en el proyecto que estés, presiona **`Espacio + o + n`** (o escribe `:Obsidian new Comandos de Docker`).
   - El plugin convierte automáticamente el título en un nombre de archivo limpio en minúsculas con guiones:
     - Escribes: `Comandos de Docker` → Crea el archivo: **`comandos-de-docker.md`**
     - Si lo quieres dentro de una subcarpeta, escribe: `proyectos/api-pagos` → Crea: **`proyectos/api-pagos.md`**
2. **Notas Diarias / Bitácora (`Espacio + o + d`):**
   - Presiona **`Espacio + o + d`** (*Obsidian Today*) y se abrirá (o creará automáticamente) la nota del día de hoy en **`diarias/AAAA-MM-DD.md`** (por ejemplo `diarias/2026-11-10.md`) para que anotes tus pendientes o lo que hiciste hoy.
   - Con **`Espacio + o + y`** abres la nota de **ayer** (*Yesterday*) para revisar qué dejaste pendiente.

---

### D. Cómo Enlazar Notas entre sí (Links, Backlinks, Tags y Tareas)

#### 1. Crear Enlaces entre Notas (`[[...]]`)
Dentro de cualquier archivo `.md`, escribe doble corchete **`[[`** y el autocompletado te mostrará todas tus notas existentes:
- **Enlace directo:**
  ```markdown
  Revisar la configuración en [[comandos-de-docker]]
  ```
- **Enlace con texto personalizado (Alias usando `|`):**
  ```markdown
  Aquí está mi [[comandos-de-docker|guía de Docker para producción]]
  ```
- **Enlace a una sección específica de otra nota (`#`):**
  ```markdown
  Ver [[comandos-de-docker#Redes y Volúmenes]]
  ```

#### 2. Cómo Navegar entre Enlaces y Ver Qué Notas Conectan (*Backlinks*)
- **Ir a la nota enlazada:** Pon el cursor encima de cualquier `[[nota]]` y presiona **`Enter`** (o **`gf`**). Neovim abrirá esa nota de inmediato (si la nota aún no existía, ¡la crea en ese instante!).
- **Regresar a la nota anterior:** Presiona **`Ctrl + o`** para volver exactamente a donde estabas.
- **Ver *Backlinks* (`Espacio + o + b`):** Te muestra una lista de **todas las notas de tu bóveda que mencionan o enlazan a la nota que tienes abierta**.
- **Ver todos los links salientes de la nota actual (`Espacio + o + l`):** Lista todos los enlaces que hay dentro del documento actual.

#### 3. Etiquetas (`#tags`) y Casillas de Tareas (`Checkboxes`)
- **Etiquetas:** Escribe `#docker`, `#linux`, `#pendiente` o `#bug` en cualquier parte de tus notas. Luego presiona **`Espacio + o + g`** para buscar todas las notas que tengan esa etiqueta.
- **Casillas de Tareas (Checkboxes):**
  ```markdown
  - [ ] Tarea pendiente
  - [-] Tarea en progreso
  - [x] Tarea terminada
  ```
  *(Con el cursor sobre la línea de la tarea, presiona **`Enter`**, **`Espacio + o + c`** o **`Espacio + c + h`** para marcarla o desmarcarla).*

#### 4. Extraer texto a una nota nueva (`Espacio + o + e`)
Si una nota se hizo muy larga, selecciona un párrafo en **Modo Visual (`v`)** y presiona **`Espacio + o + e`**: pedirá un nombre, moverá ese texto a una nota nueva y dejará puesto el enlace `[[nueva-nota]]` automáticamente.

---

### E. Tabla Resumen de Todos los Atajos de Obsidian

| Atajo | Comando | Qué hace |
| :--- | :--- | :--- |
| **`Espacio + o + n`** | `:Obsidian new` | Crea una nueva nota en `~/Proyectos/notas`. |
| **`Espacio + o + d`** | `:Obsidian today` | Abre o crea tu nota diaria de **hoy** (`diarias/YYYY-MM-DD.md`). |
| **`Espacio + o + y`** | `:Obsidian yesterday` | Abre la nota diaria de **ayer**. |
| **`Espacio + o + q`** | `:Obsidian quick_switch` | Busca y abre una nota por su **nombre de archivo**. |
| **`Espacio + o + s`** | `:Obsidian search` | Busca una palabra o frase **dentro del contenido** de todas tus notas. |
| **`Espacio + o + g`** | `:Obsidian tags` | Busca notas filtrando por **`#etiquetas`**. |
| **`Espacio + o + t`** | `:Obsidian template` | Inserta una plantilla desde `~/Proyectos/notas/templates/`. |
| **`Espacio + o + b`** | `:Obsidian backlinks` | Muestra qué otras notas apuntan hacia la nota actual. |
| **`Espacio + o + l`** | `:Obsidian links` | Lista todos los enlaces dentro de la nota actual. |
| **`Espacio + o + c`** | `:Obsidian toggle_checkbox` | Marca o desmarca una casilla `- [ ]` / `- [x]`. |
| **`Espacio + o + e`** *(Visual)* | `:Obsidian extract_note` | Extrae el texto seleccionado a una nota nueva y deja el link. |
| **`Espacio + o + o`** | `:Obsidian open` | Abre la nota actual en la app gráfica de Obsidian (si está instalada). |
| **`Enter`** o **`gf`** | *(Dentro de una nota)* | Abre el enlace `[[nota]]` bajo el cursor o marca un checkbox. |

---

## 3. Guía de Todas las Librerías y Plugins de tu Neovim

Aquí tienes documentadas **todas las librerías** que tienes instaladas en [`lua/plugins/`](./lua/plugins/) y [`lua/config/lazy.lua`](./lua/config/lazy.lua) para que les saques el 100% de provecho:

### 1. `oil.nvim` — Explorador de Archivos como Texto ([`lua/plugins/oil.lua`](./lua/plugins/oil.lua))
En lugar de usar un árbol lateral lento con el mouse, `Oil` abre cualquier carpeta como si fuera un buffer de Vim:
- **`-` (Guion)**: Abre la carpeta del archivo actual.
- **`Espacio + E`**: Abre la carpeta en una ventana flotante.
- **Atajos dentro de Oil:**
  - `Enter`: Abrir archivo o entrar a carpeta.
  - `-`: Subir a la carpeta anterior (padre).
  - `Ctrl + s` (en Oil): Abrir el archivo bajo el cursor en un panel vertical.
  - `Ctrl + v` (en Oil): Abrir el archivo en un panel horizontal.
  - `Ctrl + p`: Ver vista previa del archivo sin salir de Oil.
  - `g.`: Mostrar/ocultar archivos ocultos (`.gitignore`, `.env`).
  - **Crear / Renombrar / Borrar:** Simplemente agrega una línea, edita un nombre o borra una línea con `dd`, y guarda con `:w` (se te mostrará un cuadro confirmando los cambios en el disco).

### 2. `harpoon2` — Saltos Instantáneos entre Archivos Clave ([`lua/config/lazy.lua`](./lua/config/lazy.lua))
Cuando trabajas en una tarea, casi siempre te mueves entre los mismos 3 o 4 archivos:
- **`Espacio + H`**: Agrega el archivo actual a Harpoon.
- **`Espacio + h`**: Abre la ventana de Harpoon (puedes reordenar o borrar archivos de la lista como si fuera texto).
- **`Espacio + 1`**, **`2`**, **`3`**, **`4`**: Salta directamente al archivo 1, 2, 3 o 4 sin importar dónde estés.

### 3. `snacks.nvim` y `fzf-lua` — Buscador Global ([`lua/plugins/ui.lua`](./lua/plugins/ui.lua))
- **`Espacio + f + f`**: Buscar archivos por nombre en el proyecto.
- **`Espacio + s + g`**: Buscar texto en vivo (*Grep*) en todo el proyecto (funciona también seleccionando texto en modo Visual y presionando `Espacio + sg`).
- **`Espacio + s + G`** *(Visual)*: Buscar el texto seleccionado desde la raíz del repositorio Git.
- **`Espacio + f + b`**: Ver lista de archivos abiertos actualmente (*Buffers*).

### 4. `goto-preview` — Vistas Previas Flotantes de Código ([`lua/plugins/editor.lua`](./lua/plugins/editor.lua))
Inspecciona código sin cambiar de archivo:
- **`gpd`**: Ver **definición** de la función/clase en ventana flotante.
- **`gpD`**: Ver **declaración**.
- **`gpi`**: Ver **implementación**.
- **`gpy`**: Ver **definición de tipo**.
- **`gpr`**: Ver todas las **referencias** (dónde se llama a esa función).
- **`gP`**: **Cerrar todas** las ventanas flotantes abiertas.

### 5. `nvim-rip-substitute` — Buscar y Reemplazar con Vista Previa ([`lua/plugins/rip.lua`](./lua/plugins/rip.lua))
Mucho más cómodo que escribir `:%s/viejo/nuevo/g`:
- **`Espacio + f + s`** *(Normal o Visual)*: Abre una ventana flotante donde escribes qué quieres buscar arriba y por qué reemplazarlo abajo, viendo los cambios coloreados en tiempo real en tu archivo antes de aplicar con `Enter`.

### 6. `vim-multiple-cursors` — Multi-Cursores estilo VS Code ([`lua/plugins/multi-line.lua`](./lua/plugins/multi-line.lua))
- Pon el cursor sobre cualquier palabra y presiona **`Ctrl + n`**.
- Vuelve a presionar **`Ctrl + n`** para seleccionar la siguiente aparición de esa palabra (con `Ctrl + x` saltas una, con `Ctrl + p` regresas a la anterior).
- Presiona `c` (cambiar) o `i` (insertar) para escribir en todos los cursores a la vez y `Esc` para terminar.

### 7. `mini.surround` — Rodear texto con comillas, paréntesis o tags ([`lua/config/lazy.lua`](./lua/config/lazy.lua))
- **`gsa` + movimiento + carácter**: Rodear texto (ejemplo: selecciona texto en modo visual y presiona `gsa"` para ponerle comillas dobles, o `gsa)` para paréntesis).
- **`gsd` + carácter**: Borrar las comillas o paréntesis que rodean la palabra (ejemplo: `gsd"` borra las comillas `"` alrededor del cursor).
- **`gsr` + viejo + nuevo**: Reemplazar comillas o paréntesis (ejemplo: `gsr"'` cambia comillas dobles `"` por simples `'`).

### 8. `symbols-outline.nvim` — Mapa de Funciones y Clases ([`lua/plugins/overrides.lua`](./lua/plugins/overrides.lua))
- **`Espacio + c + s`**: Abre un panel a la derecha con el esquema jerárquico de todas las clases, funciones, métodos y variables del archivo actual.

### 9. `todo-comments.nvim` — Resaltado y Búsqueda de Comentarios ([`lua/plugins/ui.lua`](./lua/plugins/ui.lua))
Resalta con colores e iconos comentarios especiales en tu código:
- `TODO:`, `FIX:`, `HACK:`, `WARN:`, `PERF:`, `NOTE:`.
- **`Espacio + s + t`**: Busca todos los `TODO:` y `FIX:` pendientes en todo tu proyecto.

### 10. `git.nvim` y `mini.diff` — Integración con Git ([`lua/plugins/editor.lua`](./lua/plugins/editor.lua))
- **`Espacio + g + b`**: Abre ventana de *Git Blame* (quién modificó cada línea y en qué commit).
- **`Espacio + g + o`**: Abre el archivo actual directamente en el navegador web (GitHub).
- **`Espacio + g + g`**: Abre LazyGit (si está instalado) o controles de Git.

### 11. `nvim-dap` — Debugger Paso a Paso ([`lua/plugins/nvim-dap.lua`](./lua/plugins/nvim-dap.lua))
- **`Espacio + d + b`**: Poner o quitar un *Breakpoint* en la línea actual.
- **`Espacio + d + B`**: Poner un *Breakpoint* condicional.
- **`Espacio + d + c`**: Iniciar o continuar la ejecución (*Continue*).
- **`Espacio + d + i`** / **`d + O`** / **`d + o`**: *Step Into*, *Step Over*, *Step Out*.
- **`Espacio + d + t`**: Detener el debugger (*Terminate*).

### 12. Plugins de Entrenamiento, Privacidad y Concentración
- **`screenkey.nvim`** ([`lua/plugins/screenkey.lua`](./lua/plugins/screenkey.lua)): **`Espacio + u + k`** muestra en pantalla las teclas que presionas.
- **`vim-be-good`** ([`lua/plugins/vim-be-good.lua`](./lua/plugins/vim-be-good.lua)): Ejecuta **`:VimBeGood`** para practicar velocidad en Vim con minijuegos.
- **`zen-mode.nvim` + `twilight.nvim`** ([`lua/plugins/ui.lua`](./lua/plugins/ui.lua)): **`Espacio + z`** centra el código y oscurece el resto para concentrarte.
- **`veil.nvim`** ([`lua/plugins/veil.lua`](./lua/plugins/veil.lua)): Oculta automáticamente valores sensibles cuando abres archivos `.env`.
- **`precognition.nvim`** ([`lua/plugins/precognition.lua`](./lua/plugins/precognition.lua)): Pistas de movimientos de Vim (actívalo cambiando `enabled = true` en [`lua/plugins/disabled.lua`](./lua/plugins/disabled.lua)).

---

## 4. Soporte de Python, Node.js (`fnm`) y Temas de Color

- **Elegir entorno virtual de Python (`.venv` / `pyenv`):** Presiona **`Espacio + c + v`** (`venv-selector`) para elegir qué entorno virtual de Python usar en el proyecto.
- **Ver estado de Node.js (`fnm`):** Ejecuta **`:NodeInfo`** o **`:NodeRefresh`**.
- **Cambiar Tema de Color:** Presiona **`Espacio + u + C`** para previsualizar temas (`gentleman-kanagawa-blur`, `catppuccin`, `oldworld`, `kanagawa`, `tokyonight`), o edita la última línea de [`lua/plugins/colorscheme.lua`](./lua/plugins/colorscheme.lua).
- **Ver todos los atajos en cualquier momento:** Presiona **`Espacio + ?`**.
