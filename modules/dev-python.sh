#!/usr/bin/env bash
set -e
source "$(dirname "$0")/lib.sh"

install_pkgs "Dev — Python" \
    python python-pip python-pipx

section "pipx ensurepath"
if python -m pipx ensurepath --only-if-needed 2>/dev/null; then
    success "pipx path configured"
else
    skip "pipx path already set"
fi
