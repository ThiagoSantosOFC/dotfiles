#!/usr/bin/env bash
set -e
source "$(dirname "$0")/lib.sh"

install_pkgs "Audio (PipeWire)" \
    pipewire pipewire-alsa pipewire-jack pipewire-pulse wireplumber \
    lib32-pipewire lib32-pipewire-jack pavucontrol

section "PipeWire services"
systemctl --user enable --now pipewire pipewire-pulse wireplumber 2>/dev/null \
    && success "PipeWire enabled" \
    || warn "Could not enable PipeWire (not in a user session?)"
