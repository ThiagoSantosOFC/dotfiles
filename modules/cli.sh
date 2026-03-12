#!/usr/bin/env bash
set -e
source "$(dirname "$0")/lib.sh"

install_pkgs "Modern CLI" \
    bat eza fd dust zoxide fzf \
    lazygit git-delta \
    tealdeer jq

section "tealdeer cache"
tldr --update 2>/dev/null && success "tldr cache updated" || warn "tldr update failed (network?)"

section "git delta"
if git config --global core.pager | grep -q delta 2>/dev/null; then
    skip "git delta already configured"
else
    git config --global core.pager delta
    git config --global interactive.diffFilter "delta --color-only"
    git config --global delta.navigate true
    git config --global delta.side-by-side true
    git config --global merge.conflictStyle zdiff3
    success "git delta configured"
fi
