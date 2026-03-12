#!/usr/bin/env bash
set -e
source "$(dirname "$0")/lib.sh"

install_pkgs "Applications" \
    brave-bin firefox librewolf-bin \
    visual-studio-code-bin kate dolphin \
    mpv vlc-plugins-all imv \
    steam protonup-qt openrgb piper \
    flameshot satty spectacle \
    flatpak meld pavucontrol
