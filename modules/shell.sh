#!/usr/bin/env bash
set -e
source "$(dirname "$0")/lib.sh"

install_pkgs "Shell & Terminal" \
    zsh starship kitty fastfetch neovim \
    btop duf ripgrep tree pv micro vim vim-plug tmux \
    wget curl unzip unrar wl-clipboard cliphist

section "Default Shell"
if [ "$SHELL" = "$(which zsh)" ]; then
    skip "zsh already default shell"
else
    chsh -s "$(which zsh)"
    success "Default shell set to zsh (re-login to apply)"
fi
