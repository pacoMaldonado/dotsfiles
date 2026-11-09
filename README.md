# Dotfiles — Fedora KDE Plasma (Wayland)

Repositorio modular de **dotfiles** y automatización de entorno de desarrollo para **Fedora Linux (KDE Plasma / Wayland)**, diseñado para instalar y configurar todo el stack desde cero en cuestión de minutos y sin intervención manual.

## Agradecimientos

La arquitectura modular y el enfoque de automatización de este repositorio están inspirados en [**Gentleman.Dots**](https://github.com/Gentleman-Programming/Gentleman.Dots) de Alan Buscaglia (*Gentleman Programming*). ¡Gracias por compartir esa excelente referencia con la comunidad!

---

## Stack del Entorno

- **OS & Desktop:** Fedora Linux + KDE Plasma (Wayland)
- **Terminal:** [Ghostty](https://ghostty.org/) (`JetBrainsMono Nerd Font` / `FiraCode Nerd Font`)
- **Shell:** Zsh + [Oh My Zsh](https://ohmyz.sh/) (`zsh-autosuggestions`, `zsh-syntax-highlighting`)
- **Prompt:** [Starship](https://starship.rs/) (`starship.toml` personalizado)
- **Editor:** [Neovim](https://neovim.io/) basado en [LazyVim](https://www.lazyvim.org/)
- **Gestores de Lenguajes:** `fnm` (Node.js) y `pyenv` (Python + dependencias nativas de compilación)
- **Herramientas CLI Modernas:** `eza` (`ls`), `bat` (`cat`), `ripgrep` (`rg`), `fd-find` (`fd`), `wl-clipboard`

---

## Estructura del Repositorio

```text
dotsfiles/
├── ghostty/
│   └── config                  # Configuración de Ghostty (-> ~/.config/ghostty)
├── nvim/                       # Configuración de Neovim con LazyVim (-> ~/.config/nvim)
│   ├── init.lua
│   └── lua/
│       ├── config/
│       │   ├── autocmds.lua
│       │   ├── keymaps.lua
│       │   ├── lazy.lua
│       │   └── options.lua
│       └── plugins/
│           └── custom.lua
├── starship/
│   └── starship.toml           # Configuración de Starship (-> ~/.config/starship.toml)
├── zsh/
│   └── .zshrc                  # Configuración principal de Zsh (-> ~/.zshrc)
├── install.sh                  # Script de instalación desatendida e idempotente
├── LICENSE
└── README.md
```

---

## Cómo usar este repositorio tras formatear tu PC

1. **Instala Git (si la imagen base de Fedora no lo trae preinstalado) y clona el repositorio:**

   ```bash
   sudo dnf install -y git
   git clone https://github.com/pacoMaldonado/dotsfiles.git ~/Proyectos/dotsfiles
   cd ~/Proyectos/dotsfiles
   ```

2. **Otorga permisos de ejecución y lanza el instalador:**

   ```bash
   chmod +x install.sh
   ./install.sh
   ```

   *(Opcional)* Si deseas sobrescribir los datos de Git al vuelo:
   ```bash
   GIT_USER_NAME="Tu Nombre" GIT_USER_EMAIL="tu@email.com" ./install.sh
   ```

3. **Pasos posteriores a la ejecución (Post-Instalación):**
   - **Reinicia tu sesión de usuario** en KDE Plasma (para que el cambio de shell predeterminada a `zsh` surta efecto en todo el entorno gráfico).
   - **Abre Ghostty** y verifica que el prompt de Starship y las fuentes Nerd Font se visualicen con iconos.
   - **Instala tus versiones de Node.js y Python:**
     ```bash
     fnm install --lts
     pyenv install 3.12
     pyenv global 3.12
     ```
   - **Abre Neovim (`nvim`):** LazyVim descargará automáticamente los plugins y compilará los parsers de Treesitter desde cero.
