#!/usr/bin/env bash
set -e
source "$(dirname "$0")/lib.sh"

install_pkgs "Fonts" \
    ttf-jetbrains-mono-nerd ttf-cascadia-code-nerd ttf-firacode-nerd ttf-meslo-nerd \
    noto-fonts noto-fonts-emoji noto-fonts-cjk \
    ttf-liberation ttf-dejavu awesome-terminal-fonts \
    ttf-nerd-fonts-symbols-common ttf-nerd-fonts-symbols-mono woff2-font-awesome
