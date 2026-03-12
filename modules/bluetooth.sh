#!/usr/bin/env bash
set -e
source "$(dirname "$0")/lib.sh"

install_pkgs "Bluetooth" \
    bluez bluez-utils blueman

section "Bluetooth service"
sudo systemctl enable --now bluetooth && success "Bluetooth enabled"
