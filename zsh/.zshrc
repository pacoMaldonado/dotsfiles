# ╔══════════════════════════════════════════════════════════════════════════════╗
# ║                       DOTFILES - ZSH CONFIGURATION                           ║
# ║            Basado en Gentleman.Dots — Adaptado para Linux                    ║
# ╚══════════════════════════════════════════════════════════════════════════════╝
# Guía completa de uso, alias, plugins y gestores en: ./GUIA_ZSH.md
# TIP: Ejecuta 'reload' en la terminal para aplicar cambios sin cerrarla.


# ┌──────────────────────────────────────────────────────────────────────────────┐
# │ 1. OH MY ZSH Y PLUGINS                                                       │
# └──────────────────────────────────────────────────────────────────────────────┘
export ZSH="$HOME/.oh-my-zsh"

# Desactivamos el tema de Oh My Zsh porque usamos Starship como prompt principal
ZSH_THEME=""

# Autocompletado insensible a mayúsculas/minúsculas y guiones (_ y -)
HYPHEN_INSENSITIVE="true"

# Plugins activos
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source "$ZSH/oh-my-zsh.sh"


# ┌──────────────────────────────────────────────────────────────────────────────┐
# │ 2. MEJORAS DE HISTORIAL Y TECLADO EN ZSH                                     │
# └──────────────────────────────────────────────────────────────────────────────┘
# Evitar comandos duplicados en el historial al presionar la flecha Arriba (↑)
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS

# Atajo: Ctrl + Espacio para aceptar la sugerencia gris completa de zsh-autosuggestions
bindkey '^ ' autosuggest-accept


# ┌──────────────────────────────────────────────────────────────────────────────┐
# │ 3. VARIABLES DE ENTORNO Y PATH GENERAL                                       │
# └──────────────────────────────────────────────────────────────────────────────┘
export EDITOR="nvim"
export VISUAL="nvim"

# Agregar ~/.local/bin al PATH sin duplicarlo
case ":$PATH:" in
  *":$HOME/.local/bin:"*) ;;
  *) export PATH="$HOME/.local/bin:$PATH" ;;
esac


# ┌──────────────────────────────────────────────────────────────────────────────┐
# │ 4. GESTORES DE LENGUAJES Y PAQUETES (PYENV, FNM, PNPM)                       │
# └──────────────────────────────────────────────────────────────────────────────┘

# --- Pyenv (Python) ---
export PYENV_ROOT="$HOME/.pyenv"
[[ -d "$PYENV_ROOT/bin" ]] && export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv >/dev/null 2>&1; then
  eval "$(pyenv init - zsh)"
fi

# --- fnm (Fast Node Manager - Node.js) ---
# Unificado con --use-on-cd: cambia automáticamente de versión de Node al entrar
# a carpetas que tengan archivo .nvmrc o .node-version
export FNM_PATH="$HOME/.local/share/fnm"
if [[ -d "$FNM_PATH" ]]; then
  case ":$PATH:" in
    *":$FNM_PATH:"*) ;;
    *) export PATH="$FNM_PATH:$PATH" ;;
  esac
fi
if command -v fnm >/dev/null 2>&1; then
  eval "$(fnm env --use-on-cd --shell zsh)"
fi

# --- pnpm (Node Package Manager rápido) ---
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *":$PNPM_HOME/bin:"*) ;;
  *) [[ -d "$PNPM_HOME" ]] && export PATH="$PNPM_HOME:$PATH" ;;
esac


# ┌──────────────────────────────────────────────────────────────────────────────┐
# │ 5. ALIAS DE HERRAMIENTAS CLI MODERNAS (EZA, BAT, FD)                         │
# └──────────────────────────────────────────────────────────────────────────────┘

# eza (reemplazo moderno de ls con iconos y estado de Git)
if command -v eza >/dev/null 2>&1; then
  alias ls="eza --icons=auto --group-directories-first"
  alias ll="eza -lh --icons=auto --group-directories-first --git"
  alias la="eza -lah --icons=auto --group-directories-first --git"
  alias lt="eza --tree --level=2 --icons=auto --group-directories-first"
  alias lt3="eza --tree --level=3 --icons=auto --group-directories-first"
fi

# bat (reemplazo moderno de cat con resaltado de sintaxis)
if command -v bat >/dev/null 2>&1; then
  alias cat="bat --paging=never"
  alias catp="bat"
fi

# fd (asegurar comando fd en distros Debian/Ubuntu/Mint donde se instala como fdfind)
if ! command -v fd >/dev/null 2>&1 && command -v fdfind >/dev/null 2>&1; then
  alias fd="fdfind"
fi

# Búsqueda interactiva con vista previa (si fzf y bat están instalados)
if command -v fzf >/dev/null 2>&1 && command -v bat >/dev/null 2>&1; then
  alias fzfbat='fzf --preview="bat --color=always {}"'
  alias fzfnvim='nvim $(fzf --preview="bat --color=always {}")'
fi


# ┌──────────────────────────────────────────────────────────────────────────────┐
# │ 6. ATAJOS PRÁCTICOS PARA EL DÍA A DÍA                                        │
# └──────────────────────────────────────────────────────────────────────────────┘

# Recargar configuración de Zsh al instante
alias reload="source ~/.zshrc && echo '✔ ~/.zshrc recargado correctamente'"

# Navegación rápida entre directorios
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Acceso directo a tu repositorio de Dotfiles y edición rápida de módulos
export DOTFILES="$HOME/Proyectos/dotsfiles"
alias dots="cd \$DOTFILES"
alias zshconfig="nvim \$DOTFILES/zsh/.zshrc"
alias ghosttyconfig="nvim \$DOTFILES/ghostty/config"
alias starshipconfig="nvim \$DOTFILES/starship/starship.toml"
alias nvimconfig="cd \$DOTFILES/nvim && nvim ."

# Utilidades rápidas de sistema
alias c="clear"
alias ports="ss -tulanp"
alias myip="curl -s ifconfig.me && echo ''"


# ┌──────────────────────────────────────────────────────────────────────────────┐
# │ 7. INICIALIZACIÓN DEL PROMPT (STARSHIP)                                      │
# └──────────────────────────────────────────────────────────────────────────────┘
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi
