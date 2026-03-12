#!/usr/bin/env bash
set -e
source "$(dirname "$0")/lib.sh"

section "Containers (optional)"

if command -v docker &>/dev/null; then
    skip "Docker already installed"
elif command -v podman &>/dev/null; then
    skip "Podman already installed"
else
    ask "Install a container runtime?"
    echo "  [1] Docker"
    echo "  [2] Podman"
    echo "  [3] Skip"
    read -r container_choice

    case "$container_choice" in
        1)
            paru -S --needed --noconfirm docker docker-compose
            sudo systemctl enable --now docker
            sudo usermod -aG docker "$USER"
            success "Docker installed — re-login for group to take effect"
            ;;
        2)
            paru -S --needed --noconfirm podman podman-compose
            success "Podman installed"
            ;;
        *)
            info "Skipping containers"
            ;;
    esac
fi
