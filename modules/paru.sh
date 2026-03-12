#!/usr/bin/env bash
set -e
source "$(dirname "$0")/lib.sh"

section "AUR Helper (paru)"
if command -v paru &>/dev/null; then
    skip "paru already present"
    exit 0
fi

info "Installing paru..."
sudo pacman -S --needed --noconfirm git base-devel
tmp=$(mktemp -d)
git clone https://aur.archlinux.org/paru.git "$tmp/paru"
(cd "$tmp/paru" && makepkg -si --noconfirm)
rm -rf "$tmp"
success "paru installed"
