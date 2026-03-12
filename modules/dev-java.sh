#!/usr/bin/env bash
set -e
source "$(dirname "$0")/lib.sh"

install_pkgs "Dev — Java" \
    jdk-openjdk maven
