#!/usr/bin/env bash
# ==============================================================================
# DOTFILES AUTOMATED INSTALLER - FEDORA KDE PLASMA (WAYLAND)
# Basado e inspirado en la arquitectura modular de Gentleman.Dots
# ==============================================================================

set -euo pipefail

# ------------------------------------------------------------------------------
# Variables de Configuración (Personalizables o vía variables de entorno)
# ------------------------------------------------------------------------------
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FONT_DIR="$HOME/.local/share/fonts"
OBSIDIAN_VAULT_DIR="${OBSIDIAN_VAULT:-$HOME/Proyectos/notas}"
NOTES_REPO_URL="${NOTES_REPO_URL:-git@github.com:pacoMaldonado/notas.git}"
BACKUP_SUFFIX=".bak"

GIT_USER_NAME="${GIT_USER_NAME:-Javier Maldonado Hernández}"
GIT_USER_EMAIL="${GIT_USER_EMAIL:-37282715+pacoMaldonado@users.noreply.github.com}"

# Colores para logs
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info()    { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[OK]${NC} $1"; }
log_warn()    { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error()   { echo -e "${RED}[ERROR]${NC} $1"; }

# ------------------------------------------------------------------------------
# 1. Permisos Sudo e Instalación de Paquetes vía DNF
# ------------------------------------------------------------------------------
install_packages() {
  log_info "Solicitando permisos sudo para la instalación de paquetes..."
  sudo -v

  # Mantener sudo activo mientras corre el script
  while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

  local base_packages=(
    gcc-c++
    make
    nodejs
    git
    wl-clipboard
    zsh
    neovim
    curl
    wget
    unzip
    tar
    fontconfig
    util-linux-user
  )

  local cli_packages=(
    ripgrep
    fd-find
    bat
    fzf
  )

  local python_build_deps=(
    gcc
    zlib-devel
    bzip2
    bzip2-devel
    readline-devel
    sqlite
    sqlite-devel
    openssl-devel
    tk-devel
    libffi-devel
    xz-devel
  )

  log_info "Instalando dependencias base, herramientas CLI y dependencias de compilación de Python..."
  sudo dnf install -y --skip-unavailable \
    "${base_packages[@]}" \
    "${cli_packages[@]}" \
    "${python_build_deps[@]}"

  # eza (En Fedora 41+ puede no estar en los repos oficiales; intentamos dnf y fallback a binario oficial)
  if ! command -v eza >/dev/null 2>&1; then
    log_info "Instalando eza..."
    if ! sudo dnf install -y eza 2>/dev/null; then
      log_warn "eza no disponible en repositorios estándar de DNF; instalando binario oficial en ~/.local/bin..."
      mkdir -p "$HOME/.local/bin"
      local arch
      arch="$(uname -m)"
      curl -fsSL "https://github.com/eza-community/eza/releases/latest/download/eza_${arch}-unknown-linux-gnu.tar.gz" \
        | tar -xz -C "$HOME/.local/bin"
      chmod +x "$HOME/.local/bin/eza"
    fi
  fi

  # Starship Prompt
  if ! command -v starship >/dev/null 2>&1; then
    log_info "Instalando Starship prompt..."
    if ! sudo dnf install -y starship 2>/dev/null; then
      mkdir -p "$HOME/.local/bin"
      curl -sS https://starship.rs/install.sh | sh -s -- -y -b "$HOME/.local/bin"
    fi
  fi

  # Ghostty Terminal (vía DNF / COPR pgdev/ghostty si aún no está instalado)
  if ! command -v ghostty >/dev/null 2>&1; then
    log_info "Instalando Ghostty terminal..."
    if ! sudo dnf install -y ghostty 2>/dev/null; then
      sudo dnf copr enable -y pgdev/ghostty && sudo dnf install -y ghostty
    fi
  fi

  log_success "Paquetes del sistema instalados correctamente."
}

# ------------------------------------------------------------------------------
# 2. Descarga e Instalación de Nerd Fonts (JetBrainsMono & FiraCode)
# ------------------------------------------------------------------------------
install_fonts() {
  log_info "Verificando e instalando Nerd Fonts en $FONT_DIR..."
  mkdir -p "$FONT_DIR"

  local fonts=("JetBrainsMono" "FiraCode")
  local nf_version="v3.3.0"
  local cache_needed=false

  for font in "${fonts[@]}"; do
    # Verificar si ya existen archivos de la fuente en ~/.local/share/fonts (directo o en subcarpeta)
    if compgen -G "$FONT_DIR/${font}*" >/dev/null || [[ -d "$FONT_DIR/$font" ]]; then
      log_info "La fuente $font Nerd Font ya está instalada. Omitiendo descarga."
    else
      log_info "Descargando ${font} Nerd Font..."
      local tmp_zip="/tmp/${font}.zip"
      curl -fsSL "https://github.com/ryanoasis/nerd-fonts/releases/download/${nf_version}/${font}.zip" -o "$tmp_zip"
      mkdir -p "$FONT_DIR/$font"
      unzip -oq "$tmp_zip" -d "$FONT_DIR/$font"
      rm -f "$tmp_zip" "$FONT_DIR/$font/"*Windows* 2>/dev/null || true
      cache_needed=true
    fi
  done

  if [[ "$cache_needed" == true ]]; then
    log_info "Actualizando caché de fuentes con fc-cache -fv..."
    fc-cache -fv "$FONT_DIR"
  else
    fc-cache -f "$FONT_DIR"
  fi

  log_success "Nerd Fonts listas."
}

# ------------------------------------------------------------------------------
# 3. Instalación de Oh My Zsh, Plugins y Cambio de Shell a Zsh
# ------------------------------------------------------------------------------
setup_zsh() {
  if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    log_info "Instalando Oh My Zsh de forma desatendida..."
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c \
      "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  else
    log_info "Oh My Zsh ya está instalado."
  fi

  local zsh_custom="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
  mkdir -p "$zsh_custom/plugins"

  # Plugin: zsh-autosuggestions
  if [[ ! -d "$zsh_custom/plugins/zsh-autosuggestions" ]]; then
    log_info "Clonando zsh-autosuggestions..."
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions \
      "$zsh_custom/plugins/zsh-autosuggestions"
  else
    log_info "Actualizando zsh-autosuggestions..."
    git -C "$zsh_custom/plugins/zsh-autosuggestions" pull --ff-only || true
  fi

  # Plugin: zsh-syntax-highlighting
  if [[ ! -d "$zsh_custom/plugins/zsh-syntax-highlighting" ]]; then
    log_info "Clonando zsh-syntax-highlighting..."
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git \
      "$zsh_custom/plugins/zsh-syntax-highlighting"
  else
    log_info "Actualizando zsh-syntax-highlighting..."
    git -C "$zsh_custom/plugins/zsh-syntax-highlighting" pull --ff-only || true
  fi

  # Cambiar la shell por defecto a Zsh si aún no lo es
  local zsh_path
  zsh_path="$(command -v zsh)"
  local current_shell
  current_shell="$(getent passwd "$USER" | cut -d: -f7)"

  if [[ "$current_shell" != "$zsh_path" ]]; then
    log_info "Cambiando la shell predeterminada de $USER a $zsh_path..."
    sudo usermod -s "$zsh_path" "$USER"
  else
    log_info "Zsh ya es la shell predeterminada."
  fi

  log_success "Oh My Zsh y plugins configurados."
}

# ------------------------------------------------------------------------------
# 4. Gestión de Archivos: Respaldos (.bak) y Enlaces Simbólicos (ln -s)
# ------------------------------------------------------------------------------
backup_and_link() {
  local src="$1"
  local dest="$2"

  mkdir -p "$(dirname "$dest")"

  # Si el destino ya es un symlink que apunta exactamente a nuestro archivo fuente, no hacer nada
  if [[ -L "$dest" ]] && [[ "$(readlink -f "$dest")" == "$(readlink -f "$src")" ]]; then
    log_info "Enlace simbólico ya activo: $dest -> $src"
    return 0
  fi

  # Si existe un archivo, directorio o symlink previo diferente, crear respaldo .bak
  if [[ -e "$dest" || -L "$dest" ]]; then
    local backup_path="${dest}${BACKUP_SUFFIX}"
    if [[ -e "$backup_path" || -L "$backup_path" ]]; then
      rm -rf "$backup_path"
    fi
    log_warn "Creando respaldo: $dest -> $backup_path"
    mv "$dest" "$backup_path"
  fi

  ln -s "$src" "$dest"
  log_success "Enlace creado: $dest -> $src"
}

setup_symlinks() {
  log_info "Configurando respaldos (.bak) y enlaces simbólicos..."
  mkdir -p "$HOME/.config"

  backup_and_link "$DOTFILES_DIR/zsh/.zshrc"             "$HOME/.zshrc"
  backup_and_link "$DOTFILES_DIR/nvim"                   "$HOME/.config/nvim"
  backup_and_link "$DOTFILES_DIR/ghostty"                "$HOME/.config/ghostty"
  backup_and_link "$DOTFILES_DIR/starship/starship.toml" "$HOME/.config/starship.toml"
}

# ------------------------------------------------------------------------------
# 5. Instalación Desatendida de Gestores de Lenguajes (fnm y pyenv)
# ------------------------------------------------------------------------------
install_language_managers() {
  # --- fnm (Node.js) ---
  if ! command -v fnm >/dev/null 2>&1 && [[ ! -d "$HOME/.local/share/fnm" ]]; then
    log_info "Instalando fnm de forma desatendida..."
    if grep -q "fnm env" "$HOME/.zshrc" 2>/dev/null; then
      curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell
    else
      curl -fsSL https://fnm.vercel.app/install | bash
    fi
  else
    log_info "fnm ya está instalado."
  fi

  # Instalar Node LTS automáticamente con fnm si aún no hay ninguna versión instalada
  local fnm_bin="$HOME/.local/share/fnm/fnm"
  if command -v fnm >/dev/null 2>&1; then
    fnm_bin="$(command -v fnm)"
  fi
  if [[ -x "$fnm_bin" ]]; then
    if ! "$fnm_bin" list 2>/dev/null | grep -q "v"; then
      log_info "Instalando Node.js LTS con fnm..."
      "$fnm_bin" install --lts
    fi
  fi

  # --- pyenv (Python) ---
  if [[ ! -d "$HOME/.pyenv" ]]; then
    log_info "Instalando pyenv de forma desatendida..."
    curl -fsSL https://pyenv.run | bash
  else
    log_info "pyenv ya está instalado en ~/.pyenv."
  fi

  log_success "Gestores de lenguajes (fnm y pyenv) listos."
}

# ------------------------------------------------------------------------------
# 6. Bóveda de Notas de Obsidian (~/Proyectos/notas)
# ------------------------------------------------------------------------------
setup_obsidian_vault() {
  log_info "Verificando bóveda de notas de Obsidian en $OBSIDIAN_VAULT_DIR..."
  if [[ ! -d "$OBSIDIAN_VAULT_DIR/.git" ]]; then
    if git ls-remote "$NOTES_REPO_URL" >/dev/null 2>&1; then
      log_info "Clonando repositorio privado de notas desde $NOTES_REPO_URL..."
      rm -rf "$OBSIDIAN_VAULT_DIR"
      git clone "$NOTES_REPO_URL" "$OBSIDIAN_VAULT_DIR"
    else
      log_info "Creando estructura local de bóveda en $OBSIDIAN_VAULT_DIR (puedes enlazar tu repo privado después)..."
      mkdir -p "$OBSIDIAN_VAULT_DIR/diarias" "$OBSIDIAN_VAULT_DIR/proyectos" "$OBSIDIAN_VAULT_DIR/templates"
    fi
  else
    log_info "Repositorio de notas ya presente en $OBSIDIAN_VAULT_DIR."
  fi
}

# ------------------------------------------------------------------------------
# 7. Configuración Global de Git
# ------------------------------------------------------------------------------
setup_git() {
  log_info "Configurando Git globalmente..."

  git config --global user.name "$GIT_USER_NAME"
  git config --global user.email "$GIT_USER_EMAIL"
  git config --global init.defaultBranch main
  git config --global color.ui auto
  git config --global pull.rebase false

  log_success "Git configurado para: $GIT_USER_NAME <$GIT_USER_EMAIL>"
}

# ------------------------------------------------------------------------------
# 8. Limpieza Preventiva del Estado de Neovim
# ------------------------------------------------------------------------------
clean_nvim_state() {
  log_info "Limpiando estado previo de Neovim para asegurar una instalación limpia de Treesitter..."
  rm -rf "$HOME/.local/share/nvim"
  rm -rf "$HOME/.local/state/nvim"
  rm -rf "$HOME/.cache/nvim"
  log_success "Directorios ~/.local/share/nvim y ~/.local/state/nvim eliminados preventivamente."
}

# ------------------------------------------------------------------------------
# Ejecución Principal
# ------------------------------------------------------------------------------
main() {
  echo -e "${GREEN}======================================================================${NC}"
  echo -e "${GREEN} Iniciando instalación automatizada de Dotfiles (Fedora KDE Wayland)  ${NC}"
  echo -e "${GREEN}======================================================================${NC}"

  install_packages
  install_fonts
  setup_zsh
  setup_symlinks
  install_language_managers
  setup_obsidian_vault
  setup_git
  clean_nvim_state

  echo ""
  echo -e "${GREEN}======================================================================${NC}"
  echo -e "${GREEN} ¡Instalación completada con éxito!                                   ${NC}"
  echo -e "${GREEN} Cierra sesión o abre una nueva ventana de Ghostty para iniciar Zsh.  ${NC}"
  echo -e "${GREEN}======================================================================${NC}"
}

main "$@"
