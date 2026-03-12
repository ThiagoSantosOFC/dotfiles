#!/usr/bin/env bash
set -e
source "$(dirname "$0")/lib.sh"

install_pkgs "Dev — JavaScript / Node.js" \
    nodejs npm \
    yarn \
    pnpm-bin \
    bun-bin

section "nvm (Node Version Manager)"
if [ -d "$HOME/.nvm" ]; then
    skip "nvm already installed at ~/.nvm"
else
    info "Installing nvm..."
    curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/HEAD/install.sh | bash
    success "nvm installed — restart shell or source ~/.zshrc to activate"
fi
