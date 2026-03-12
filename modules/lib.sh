#!/usr/bin/env bash
# Shared helpers — sourced by every module. Not meant to be run directly.

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; BOLD='\033[1m'; RESET='\033[0m'

info()    { echo -e "${CYAN}  →${RESET} $*"; }
success() { echo -e "${GREEN}  ✓${RESET} $*"; }
warn()    { echo -e "${YELLOW}  !${RESET} $*"; }
skip()    { echo -e "  ${BOLD}–${RESET} $*"; }
error()   { echo -e "${RED}  ✗${RESET} $*"; exit 1; }
section() { echo -e "\n${BOLD}${CYAN}══ $* ══${RESET}"; }
ask()     { echo -e "${YELLOW}  ?${RESET} $*"; }

DOTFILES="${DOTFILES:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
BACKUP="${BACKUP:-$HOME/.dotfiles-backup-$(date +%Y%m%d%H%M%S)}"
FORCE="${FORCE:-false}"

install_pkgs() {
    local label="$1"; shift
    section "$label"
    paru -S --needed --noconfirm "$@" && success "Done"
}

link() {
    local rel="$1"
    local src="$DOTFILES/$rel"
    local dst="$HOME/$rel"

    mkdir -p "$(dirname "$dst")"

    if [ -L "$dst" ]; then
        if [ "$(readlink "$dst")" = "$src" ]; then
            skip "already linked: $rel"
            return
        fi
        if $FORCE; then
            ln -sfn "$src" "$dst" && success "re-linked: $rel"
        else
            warn "symlink exists but points elsewhere: $rel (--force to update)"
        fi
        return
    fi

    if [ -e "$dst" ]; then
        if $FORCE; then
            mkdir -p "$BACKUP/$(dirname "$rel")"
            mv "$dst" "$BACKUP/$rel"
            warn "backed up: $rel"
            ln -sfn "$src" "$dst" && success "linked: $rel"
        else
            warn "skipping $rel — file exists (--force to backup & overwrite)"
        fi
        return
    fi

    ln -sfn "$src" "$dst" && success "linked: $rel"
}
