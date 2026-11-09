# ==============================================================================
# CONFIGURACIÓN BASE DE ZSH + OH MY ZSH
# ==============================================================================

# Ruta a la instalación de Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"

# Desactivar tema de Oh My Zsh (usamos Starship como prompt)
ZSH_THEME=""

# Plugins cargados (requiere clonar zsh-autosuggestions y zsh-syntax-highlighting)
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source "$ZSH/oh-my-zsh.sh"

# ==============================================================================
# VARIABLES DE ENTORNO Y PATH
# ==============================================================================
export PATH="$HOME/.local/bin:$PATH"
export EDITOR="nvim"
export VISUAL="nvim"

# ==============================================================================
# ALIAS DE HERRAMIENTAS CLI MODERNAS
# ==============================================================================
# eza (reemplazo moderno de ls)
if command -v eza >/dev/null 2>&1; then
  alias ls="eza --icons=auto --group-directories-first"
  alias ll="eza -lh --icons=auto --group-directories-first --git"
  alias la="eza -lah --icons=auto --group-directories-first --git"
  alias lt="eza --tree --level=2 --icons=auto"
fi

# bat (reemplazo moderno de cat)
if command -v bat >/dev/null 2>&1; then
  alias cat="bat --paging=never"
  alias catp="bat"
fi

# fd (en Fedora el binario suele instalarse como fd, pero aseguramos el alias si fuera fdfind)
if ! command -v fd >/dev/null 2>&1 && command -v fdfind >/dev/null 2>&1; then
  alias fd="fdfind"
fi

# ==============================================================================
# GESTORES DE LENGUAJES
# ==============================================================================

# --- Pyenv (Python) ---
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv >/dev/null 2>&1; then
  eval "$(pyenv init - zsh)"
fi

# --- fnm (Node.js) ---
# NOTA: El instalador de fnm (curl -fsSL https://fnm.vercel.app/install | bash)
# agregará automáticamente su bloque de inicialización al final de este archivo
# (o aquí debajo).
# ==============================================================================
# PROMPT: STARSHIP
# ==============================================================================
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi
