#!/usr/bin/env bash
set -e

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; BOLD='\033[1m'; RESET='\033[0m'

info()    { echo -e "${CYAN}  →${RESET} $*"; }
success() { echo -e "${GREEN}  ✓${RESET} $*"; }
warn()    { echo -e "${YELLOW}  !${RESET} $*"; }
error()   { echo -e "${RED}  ✗${RESET} $*"; exit 1; }
section() { echo -e "\n${BOLD}${CYAN}══ $* ══${RESET}"; }

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
export DOTFILES

export BACKUP="$HOME/.dotfiles-backup-$(date +%Y%m%d%H%M%S)"
export FORCE=false

ALL_MODULES=(
    paru
    shell
    cli
    hyprland
    audio
    bluetooth
    nvidia
    fonts
    theme
    apps
    dev-base
    dev-js
    dev-python
    dev-java
    containers
    dotfiles
)

usage() {
    echo "Usage: $0 [--force] [module1 module2 ...]"
    echo ""
    echo "Available modules:"
    for m in "${ALL_MODULES[@]}"; do
        echo "  $m"
    done
    echo ""
    echo "Meta-modules (groups):"
    echo "  dev   — runs dev-base + dev-js + dev-python + dev-java"
    echo ""
    echo "Examples:"
    echo "  $0                        — run all modules"
    echo "  $0 dev                    — install all dev tooling"
    echo "  $0 dev-js dev-python      — run only those modules"
    echo "  $0 --force dotfiles       — run dotfiles module with force"
    exit 0
}

if ! command -v pacman &>/dev/null; then
    error "This script requires an Arch-based distro (Arch, CachyOS, Manjaro…)"
fi

REQUESTED=()
for arg in "$@"; do
    case "$arg" in
        --force) export FORCE=true ;;
        --help|-h) usage ;;
        *) REQUESTED+=("$arg") ;;
    esac
done

if [ "${#REQUESTED[@]}" -eq 0 ]; then
    RUN_MODULES=("${ALL_MODULES[@]}")
else
    RUN_MODULES=("${REQUESTED[@]}")
fi

$FORCE && warn "Force mode enabled — existing configs will be backed up and overwritten"

FAILED=()

for module in "${RUN_MODULES[@]}"; do
    script="$DOTFILES/modules/$module.sh"
    if [ ! -f "$script" ]; then
        warn "Module not found: $module — skipping"
        continue
    fi
    section "Module: $module"
    if bash "$script"; then
        success "Module $module complete"
    else
        warn "Module $module exited with errors"
        FAILED+=("$module")
    fi
done

echo ""
if [ "${#FAILED[@]}" -eq 0 ]; then
    echo -e "${GREEN}${BOLD}All done!${RESET}"
else
    echo -e "${YELLOW}${BOLD}Done with warnings. Failed modules:${RESET}"
    for m in "${FAILED[@]}"; do
        echo -e "  ${RED}✗${RESET} $m"
    done
fi

$FORCE && [ -d "$BACKUP" ] && echo -e "${YELLOW}Previous files backed up to: $BACKUP${RESET}"
echo -e "${CYAN}  →${RESET} Re-login or open a new terminal to apply shell changes."
