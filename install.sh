#!/bin/bash
# Dotfiles install script — symlinks configs into $HOME
set -e

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
BACKUP="$HOME/.dotfiles-backup-$(date +%Y%m%d%H%M%S)"

link() {
    local src="$DOTFILES/$1"
    local dst="$HOME/$1"
    mkdir -p "$(dirname "$dst")"
    if [ -e "$dst" ] && [ ! -L "$dst" ]; then
        mkdir -p "$BACKUP/$(dirname "$1")"
        mv "$dst" "$BACKUP/$1"
        echo "  backed up: $1"
    fi
    ln -sfn "$src" "$dst"
    echo "  linked: $1"
}

echo "Installing dotfiles from $DOTFILES"

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
    name="$(basename "$f")"
    ln -sfn "$f" "$HOME/.scripts/$name"
    chmod +x "$HOME/.scripts/$name"
done
echo "  linked: .scripts/*"

echo ""
echo "Done. Previous files backed up to: $BACKUP"
