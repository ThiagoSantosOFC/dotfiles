#!/bin/bash
# Dotfiles install script — installs packages & symlinks configs
set -e

# ── Colors ──────────────────────────────────────────────────────────────────
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; BOLD='\033[1m'; RESET='\033[0m'

info()    { echo -e "${CYAN}  →${RESET} $*"; }
success() { echo -e "${GREEN}  ✓${RESET} $*"; }
warn()    { echo -e "${YELLOW}  !${RESET} $*"; }
error()   { echo -e "${RED}  ✗${RESET} $*"; exit 1; }
section() { echo -e "\n${BOLD}${CYAN}══ $* ══${RESET}"; }

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
BACKUP="$HOME/.dotfiles-backup-$(date +%Y%m%d%H%M%S)"

# ── Arch check ───────────────────────────────────────────────────────────────
if ! command -v pacman &>/dev/null; then
    error "This script requires an Arch-based distro (Arch, CachyOS, Manjaro…)"
fi

# ── paru (AUR helper) ────────────────────────────────────────────────────────
section "AUR Helper"
if ! command -v paru &>/dev/null; then
    info "Installing paru..."
    sudo pacman -S --needed --noconfirm git base-devel
    tmp=$(mktemp -d)
    git clone https://aur.archlinux.org/paru.git "$tmp/paru"
    (cd "$tmp/paru" && makepkg -si --noconfirm)
    rm -rf "$tmp"
    success "paru installed"
else
    success "paru already installed"
fi

# ── Package install helper ───────────────────────────────────────────────────
install_pkgs() {
    local label="$1"; shift
    section "$label"
    paru -S --needed --noconfirm "$@" && success "Done"
}

# ── Shell & Terminal ─────────────────────────────────────────────────────────
install_pkgs "Shell & Terminal" \
    zsh starship kitty fastfetch \
    btop duf ripgrep tree pv micro vim vim-plug \
    wget curl unzip unrar wl-clipboard cliphist

# ── Hyprland ─────────────────────────────────────────────────────────────────
install_pkgs "Hyprland" \
    hyprland hyprpaper hyprpicker hyprshot hyprexpose-git \
    hyprpanel-bin nwg-dock-hyprland xdg-desktop-portal-hyprland \
    waybar swaybg swaync wofi uwsm \
    dunst playerctl brightnessctl

# ── Audio ─────────────────────────────────────────────────────────────────────
install_pkgs "Audio (PipeWire)" \
    pipewire pipewire-alsa pipewire-jack pipewire-pulse wireplumber \
    lib32-pipewire lib32-pipewire-jack pavucontrol

# ── Bluetooth ─────────────────────────────────────────────────────────────────
install_pkgs "Bluetooth" \
    bluez bluez-utils blueman

# ── NVIDIA ───────────────────────────────────────────────────────────────────
install_pkgs "NVIDIA" \
    nvidia-open-dkms nvidia-utils nvidia-settings \
    lib32-nvidia-utils lib32-opencl-nvidia opencl-nvidia \
    libva-nvidia-driver vulkan-icd-loader lib32-vulkan-icd-loader egl-wayland

# ── Fonts ─────────────────────────────────────────────────────────────────────
install_pkgs "Fonts" \
    ttf-jetbrains-mono-nerd ttf-cascadia-code-nerd ttf-firacode-nerd ttf-meslo-nerd \
    noto-fonts noto-fonts-emoji noto-fonts-cjk \
    ttf-liberation ttf-dejavu awesome-terminal-fonts \
    ttf-nerd-fonts-symbols-common ttf-nerd-fonts-symbols-mono woff2-font-awesome

# ── Theme & Appearance ────────────────────────────────────────────────────────
install_pkgs "Theme & Appearance" \
    catppuccin-gtk-theme-mocha kvantum kvantum-theme-catppuccin-git \
    papirus-icon-theme qt5ct qt6ct

# ── Applications ──────────────────────────────────────────────────────────────
install_pkgs "Applications" \
    brave-bin firefox librewolf-bin \
    visual-studio-code-bin kate dolphin \
    mpv vlc-plugins-all imv \
    steam protonup-qt openrgb piper \
    flameshot satty spectacle \
    flatpak meld pavucontrol

# ── Development ───────────────────────────────────────────────────────────────
install_pkgs "Development" \
    git github-cli openssh \
    nodejs npm yarn nvm \
    python python-pip python-pipx \
    jdk-openjdk maven php

# ── Enable systemd services ───────────────────────────────────────────────────
section "Services"
systemctl --user enable --now pipewire pipewire-pulse wireplumber 2>/dev/null && success "PipeWire enabled"
sudo systemctl enable --now bluetooth 2>/dev/null && success "Bluetooth enabled"
sudo systemctl enable --now NetworkManager 2>/dev/null && success "NetworkManager enabled"

# ── Symlinks ──────────────────────────────────────────────────────────────────
section "Dotfiles"

link() {
    local src="$DOTFILES/$1"
    local dst="$HOME/$1"
    mkdir -p "$(dirname "$dst")"
    if [ -e "$dst" ] && [ ! -L "$dst" ]; then
        mkdir -p "$BACKUP/$(dirname "$1")"
        mv "$dst" "$BACKUP/$1"
        warn "backed up: $1"
    fi
    ln -sfn "$src" "$dst"
    success "linked: $1"
}

link .zshrc
link .zshenv
link .config/starship.toml

link .config/hypr/hyprland.conf
link .config/hypr/hyprpaper.conf
link .config/hypr/increase_volume.sh
link .config/nwg-dock-hyprland/style.css
link .config/nwg-dock-hyprland/config
link .config/kitty/kitty.conf
link .config/kitty/theme.conf
link .config/waybar/config.jsonc
link .config/waybar/style.css
link .config/gtk-3.0/settings.ini
link .config/gtk-4.0/settings.ini

mkdir -p "$HOME/.scripts"
for f in "$DOTFILES/.scripts/"*; do
    [ -e "$f" ] || continue
    name="$(basename "$f")"
    ln -sfn "$f" "$HOME/.scripts/$name"
    chmod +x "$HOME/.scripts/$name"
    success "linked: .scripts/$name"
done

# ── Set zsh as default shell ───────────────────────────────────────────────────
if [ "$SHELL" != "$(which zsh)" ]; then
    section "Default Shell"
    chsh -s "$(which zsh)"
    success "Default shell set to zsh (re-login to apply)"
fi

echo -e "\n${GREEN}${BOLD}All done!${RESET}"
[ -d "$BACKUP" ] && echo -e "${YELLOW}Previous files backed up to: $BACKUP${RESET}"
