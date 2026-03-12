#!/usr/bin/env bash
set -e
source "$(dirname "$0")/lib.sh"

install_pkgs "Dev — Base" \
    git github-cli openssh \
    go rustup

section "Rust stable toolchain"
rustup default stable && success "Rust stable set"
