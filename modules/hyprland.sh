#!/usr/bin/env bash
set -e
source "$(dirname "$0")/lib.sh"

install_pkgs "Hyprland" \
    hyprland hyprpaper hyprpicker hyprshot hyprexpose-git \
    hyprpanel-bin nwg-dock-hyprland xdg-desktop-portal-hyprland \
    waybar swaybg swaync wofi uwsm \
    dunst playerctl brightnessctl
