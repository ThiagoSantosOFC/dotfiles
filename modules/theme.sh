#!/usr/bin/env bash
set -e
source "$(dirname "$0")/lib.sh"

install_pkgs "Theme & Appearance" \
    catppuccin-gtk-theme-mocha kvantum kvantum-theme-catppuccin-git \
    papirus-icon-theme qt5ct qt6ct
