# Guía Completa de Zsh (`.zshrc`) — Uso Diario, Alias y Gestores

> **Referencia:** Configuración basada en [Gentleman.Dots](https://github.com/Gentleman-Programming/Gentleman.Dots) y optimizada con **Oh My Zsh, Starship, `fnm`, `pyenv`, `pnpm`, `eza` y `bat`**.

---

## 1. Alias y Comandos Rápidos para tu Día a Día

### Listado de Archivos Moderno (`eza`) y Lectura (`bat`)

| Comando | Qué ejecuta por debajo | Para qué sirve |
| :--- | :--- | :--- |
| **`ls`** | `eza --icons=auto --group-directories-first` | Lista archivos con iconos y agrupa las carpetas primero. |
| **`ll`** | `eza -lh --icons=auto --group-directories-first --git` | Lista detallada (peso, fecha, permisos y **estado de Git** de cada archivo). |
| **`la`** | `eza -lah --icons=auto --group-directories-first --git` | Igual que `ll`, pero incluyendo **archivos ocultos** (`.env`, `.git`, `.zshrc`). |
| **`lt`** | `eza --tree --level=2 ...` | Muestra la carpeta actual en **vista de árbol** (2 niveles de profundidad). |
| **`lt3`** | `eza --tree --level=3 ...` | Vista de árbol a **3 niveles** de profundidad. |
| **`cat archivo`** | `bat --paging=never` | Muestra el contenido del archivo en terminal con **colores de sintaxis** y numeración de líneas sin pausar pantalla. |
| **`catp archivo`** | `bat` | Abre el archivo con paginador interactivo (para archivos muy largos, sales con `q`). |

### Navegación y Acceso Instantáneo a tus Configuraciones

| Comando | Acción |
| :--- | :--- |
| **`reload`** | Recarga `~/.zshrc` al instante sin cerrar la terminal. |
| **`..`** / **`...`** / **`....`** | Sube 1, 2 o 3 carpetas hacia atrás (`cd ..`, `cd ../..`, `cd ../../..`). |
| **`dots`** | Te lleva directamente a tu repositorio `~/Proyectos/dotsfiles`. |
| **`zshconfig`** | Abre `zsh/.zshrc` directamente en Neovim desde cualquier lugar. |
| **`ghosttyconfig`** | Abre `ghostty/config` directamente en Neovim. |
| **`starshipconfig`** | Abre `starship/starship.toml` directamente en Neovim. |
| **`nvimconfig`** | Entra a `nvim/` y abre tu configuración de Neovim. |
| **`ports`** | Muestra todos los puertos abiertos y qué programa los está usando (`ss -tulanp`). |
| **`myip`** | Muestra tu dirección IP pública actual. |

---

## 2. Cómo Aprovechar los Plugins de Zsh Instalados

### A. `zsh-autosuggestions` (Sugerencias en color gris mientras escribes)
Cuando empiezas a escribir un comando que ya usaste antes, Zsh te muestra el resto del comando en **gris claro**:
- **`Flecha Derecha (→)`** o **`Ctrl + Espacio`**: Acepta **toda** la sugerencia gris de golpe.
- **`Ctrl + Flecha Derecha`**: Acepta solo la **siguiente palabra** de la sugerencia (muy útil cuando quieres reutilizar solo la primera parte de un comando y cambiar el final).

### B. `zsh-syntax-highlighting` (Validación en vivo de comandos)
Mientras escribes:
- Si el comando se pinta en **verde**, el programa o alias **existe y es válido**.
- Si se pinta en **rojo**, el comando **está mal escrito o no está instalado** (así te das cuenta antes de presionar `Enter`).

### C. Plugin `git` de Oh My Zsh (Atajos cortos para Git)
Al tener activo el plugin `git`, puedes usar estas abreviaturas en cualquier repositorio:

| Atajo | Equivale a escribir |
| :--- | :--- |
| **`gst`** | `git status` |
| **`ga .`** o **`gaa`** | `git add .` / `git add --all` |
| **`gcmsg "mensaje"`** | `git commit -m "mensaje"` |
| **`gp`** | `git push` |
| **`gl`** | `git pull` |
| **`gco nombre-rama`** | `git checkout nombre-rama` |
| **`gcb nueva-rama`** | `git checkout -b nueva-rama` (crea y cambia de rama) |
| **`gd`** | `git diff` |
| **`glog`** | `git log --oneline --decorate --graph` (historial visual de ramas) |

---

## 3. Cómo Usar tus Gestores de Lenguajes (`fnm` y `pyenv`)

### Node.js con `fnm` (Fast Node Manager)
Tu `.zshrc` ya tiene activo `--use-on-cd`, por lo que si entras a una carpeta que tenga `.nvmrc` o `.node-version`, cambiará de versión de Node solo.

| Comando | Para qué sirve |
| :--- | :--- |
| `fnm install --lts` | Instala la última versión LTS de Node.js. |
| `fnm install 20` | Instala Node.js v20. |
| `fnm list` | Muestra las versiones de Node que tienes instaladas en tu PC. |
| `fnm default 22` | Define Node 22 como la versión por defecto al abrir la terminal. |
| `fnm use 20` | Cambia a Node 20 en la ventana actual. |

### Python con `pyenv`

| Comando | Para qué sirve |
| :--- | :--- |
| `pyenv install --list` | Lista todas las versiones de Python disponibles para descargar. |
| `pyenv install 3.12` | Descarga y compila la última versión de la serie Python 3.12. |
| `pyenv versions` | Muestra las versiones de Python instaladas en tu PC. |
| `pyenv global 3.12` | Define Python 3.12 como versión global de tu usuario. |
| `pyenv local 3.11` | Crea un archivo `.python-version` en la carpeta actual para que ese proyecto use siempre Python 3.11. |

---

## 4. Cómo Agregar Nuevos Alias o Variables en el Futuro

1. Escribe `zshconfig` en tu terminal (se abrirá [`zsh/.zshrc`](./.zshrc) en Neovim).
2. Ve a la **Sección 6 (`ATAJOS PRÁCTICOS PARA EL DÍA A DÍA`)** y agrega tu línea, por ejemplo:
   ```zsh
   alias dev="cd ~/Proyectos"
   ```
3. Guarda el archivo y escribe **`reload`** en la terminal. ¡Tu nuevo comando estará activo de inmediato!
