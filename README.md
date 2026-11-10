# Dotfiles — Fedora KDE Plasma (Wayland)

Repositorio modular de **dotfiles** y automatización de entorno de desarrollo para **Fedora Linux (KDE Plasma / Wayland)**, diseñado para instalar y configurar todo mi entorno de trabajo en minutos tras formatear mi PC, sin intervención manual.

---

## Referencia y Agradecimientos

Este repositorio tomó como base arquitectónica e inspiración el proyecto [**Gentleman.Dots**](https://github.com/Gentleman-Programming/Gentleman.Dots) creado por **Alan Buscaglia (*Gentleman Programming*)**.

A partir de las configuraciones originales de `Gentleman.Dots` (Ghostty, Starship, Zsh y GentlemanNvim), este repositorio ha sido adaptado, depurado y personalizado a mis necesidades específicas en Linux:
- **Ghostty:** Atajos ergonómicos de 2 teclas para Linux (`Alt+c`, `Alt+v`, `Alt+x`, `Alt+r`), auto-copiado al seleccionar con el mouse, fuentes `JetBrainsMono Nerd Font` / `FiraCode Nerd Font` y colección de 51 shaders `.glsl`.
- **Starship:** Soporte visible para Python (`pyenv` / `.venv`), estado detallado de Git (`$git_status`), directorios en español e inglés, 5 paletas de colores intercambiables y prompt limpio.
- **Zsh:** Integración unificada de `fnm` (con `--use-on-cd`), `pyenv` y `pnpm`, alias modernos con `eza` y `bat`, y comandos rápidos para edición y sincronización de dotfiles y notas.
- **Neovim (LazyVim):** Detección automática de Node vía `fnm` y Python vía `pyenv`, integración directa en barra lateral con **Claude Code (`claude`)**, **Antigravity CLI (`agy`)** y **AWS Kiro CLI (`kiro-cli`)**, y gestión de notas en repositorio privado con **Obsidian (`obsidian.nvim`)**.

¡Muchas gracias a *Gentleman Programming* por compartir su trabajo con la comunidad!

---

## Guías de Uso y Personalización por Módulo

Cada módulo cuenta con su propio manual detallado en español con todos los atajos, comandos, efectos visuales, temas y ejemplos de uso para el día a día:

1. 🖥️ **[Guía Completa de Ghostty (`ghostty/GUIA_GHOSTTY.md`)](./ghostty/GUIA_GHOSTTY.md)**
   - Atajos ergonómicos de 2 teclas (`Alt + c/v/x/r/e/d`), paneles divididos, cómo probar los **51 shaders `.glsl`** en vivo y cómo cambiar entre los +300 temas de color.
2. 🚀 **[Guía Completa de Starship (`starship/GUIA_STARSHIP.md`)](./starship/GUIA_STARSHIP.md)**
   - Lectura del estado de Git y lenguajes, cómo cambiar entre las 5 paletas de colores y cómo buscar/copiar cualquiera de los +10,000 iconos de Nerd Fonts.
3. 🐚 **[Guía Completa de Zsh (`zsh/GUIA_ZSH.md`)](./zsh/GUIA_ZSH.md)**
   - Alias modernos (`ls`, `ll`, `la`, `lt`, `cat`, `dots`, `notas`, `notassync`, `reload`), uso de plugins (`zsh-autosuggestions`, `zsh-syntax-highlighting`, `git`) y comandos de `fnm` y `pyenv`.
4. ⚡ **[Guía Maestra de Neovim + IA + Obsidian (`nvim/GUIA_NEOVIM.md`)](./nvim/GUIA_NEOVIM.md)**
   - Uso de **Claude Code (`Espacio+ac`)**, **Antigravity CLI (`Espacio+ag`)**, **AWS Kiro CLI (`Espacio+ak`)**, manual completo de **Obsidian en Neovim (`Espacio+o...`)** conectado a un repositorio privado de notas, y guía de todas las librerías instaladas (`Oil`, `Harpoon 2`, `goto-preview`, `rip-substitute`, `multiple-cursors`, `DAP`, `Screenkey`, `VimBeGood`, `ZenMode`, `Veil`).

---

## Estructura del Repositorio

```text
dotsfiles/
├── ghostty/
│   ├── GUIA_GHOSTTY.md         # Manual de atajos, shaders y temas de Ghostty
│   ├── config                  # Configuración principal (-> ~/.config/ghostty/config)
│   ├── shaders/                # 51 efectos visuales OpenGL (.glsl)
│   └── themes/                 # Temas locales (gentleman.conf, catppuccin-mocha.conf)
├── nvim/
│   ├── GUIA_NEOVIM.md          # Manual maestro de Neovim, IA, Obsidian y plugins
│   ├── init.lua                # Punto de entrada (-> ~/.config/nvim)
│   └── lua/
│       ├── config/             # Opciones, keymaps, lazy.nvim y soporte fnm/pyenv
│       └── plugins/            # Plugins modulados (IA, Obsidian, Oil, UI, Temas, etc.)
├── starship/
│   ├── GUIA_STARSHIP.md        # Manual de personalización del prompt e iconos
│   └── starship.toml           # Configuración de Starship (-> ~/.config/starship.toml)
├── zsh/
│   ├── GUIA_ZSH.md             # Manual de alias, plugins de Zsh, fnm y pyenv
│   └── .zshrc                  # Configuración de Zsh (-> ~/.zshrc)
├── install.sh                  # Instalador automático, desatendido e idempotente
├── LICENSE
└── README.md
```

---

## Cómo Instalar Todo tras Formatear tu PC

En tu Fedora Linux recién instalado, abre la terminal y ejecuta:

```bash
# 1. Instalar Git (si no viene en la imagen base) y clonar este repositorio
sudo dnf install -y git
git clone https://github.com/pacoMaldonado/dotsfiles.git ~/Proyectos/dotsfiles
cd ~/Proyectos/dotsfiles

# 2. Dar permisos de ejecución y correr el instalador automatizado
chmod +x install.sh
./install.sh
```

### ¿Qué hace `install.sh` automáticamente por ti?
1. Instala todos los paquetes base (`gcc-c++`, `make`, `nodejs`, `git`, `wl-clipboard`, `zsh`, `neovim`), herramientas CLI modernas (`eza`, `bat`, `ripgrep`, `fd-find`, `fzf`), `starship`, `ghostty` y todas las librerías de compilación de Python (`zlib-devel`, `bzip2-devel`, `readline-devel`, `sqlite-devel`, `openssl-devel`, `tk-devel`, `libffi-devel`, `xz-devel`).
2. Descarga e instala `JetBrainsMono Nerd Font` y `FiraCode Nerd Font` en `~/.local/share/fonts` y actualiza la caché con `fc-cache -fv`.
3. Instala **Oh My Zsh**, clona `zsh-autosuggestions` y `zsh-syntax-highlighting`, y cambia tu shell por defecto a **Zsh**.
4. Crea respaldos `.bak` de tus configuraciones previas y enlaza simbólicamente `~/.zshrc`, `~/.config/nvim`, `~/.config/ghostty` y `~/.config/starship.toml`.
5. Instala **`fnm`** (junto con Node.js LTS) y **`pyenv`** de forma desatendida.
6. Clona tu repositorio privado de notas de Obsidian en `~/Proyectos/notas` (o crea la estructura base si aún no has configurado tus llaves SSH).
7. Configura **Git** globalmente (`user.name`, `user.email`, `init.defaultBranch main`, `color.ui auto`, `pull.rebase false`).
8. Limpia `~/.local/share/nvim` y `~/.local/state/nvim` para asegurar una instalación limpia de plugins y Treesitter al abrir Neovim.

### Pasos Finales Post-Instalación (1 minuto)
1. **Cierra sesión en KDE Plasma** y vuelve a entrar para que Zsh sea tu shell activa en todo el sistema.
2. Abre **Ghostty** e instala tu versión preferida de Python si lo requieres:
   ```bash
   pyenv install 3.12
   pyenv global 3.12
   ```
3. Ejecuta **`nvim`**: LazyVim instalará automáticamente todos los plugins y parsers de Treesitter.
