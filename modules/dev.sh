#!/usr/bin/env bash
set -e
MODULES_DIR="$(dirname "$0")"

for mod in dev-base dev-js dev-python dev-java; do
    bash "$MODULES_DIR/$mod.sh"
done
