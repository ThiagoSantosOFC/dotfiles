#!/usr/bin/env bash
set -e
source "$(dirname "$0")/lib.sh"

section "Dotfiles symlinks${FORCE:+ (force mode — will overwrite)}"

# Shell
link .zshrc
link .zshenv
link .config/starship.toml

# Hyprland
link .config/hypr/hyprland.conf
link .config/hypr/hyprpaper.conf
link .config/hypr/increase_volume.sh
link .config/nwg-dock-hyprland/style.css
link .config/nwg-dock-hyprland/config

# Kitty
link .config/kitty/kitty.conf
link .config/kitty/theme.conf

# Waybar
link .config/waybar/config.jsonc
link .config/waybar/style.css

# GTK
link .config/gtk-3.0/settings.ini
link .config/gtk-4.0/settings.ini

# Scripts
section "Scripts"
mkdir -p "$HOME/.scripts"
for f in "$DOTFILES/.scripts/"*; do
    [ -e "$f" ] || continue
    name="$(basename "$f")"
    dst="$HOME/.scripts/$name"
    if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$f" ]; then
        skip "already linked: .scripts/$name"
        continue
    fi
    ln -sfn "$f" "$dst"
    chmod +x "$dst"
    success "linked: .scripts/$name"
done

# Default shell
section "Default shell"
if [ "$SHELL" != "$(command -v zsh)" ]; then
    chsh -s "$(command -v zsh)"
    success "Default shell set to zsh (re-login to apply)"
else
    skip "zsh already default shell"
fi
