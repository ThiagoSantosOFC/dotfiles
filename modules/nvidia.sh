#!/usr/bin/env bash
set -e
source "$(dirname "$0")/lib.sh"

install_pkgs "NVIDIA" \
    nvidia-open-dkms nvidia-utils nvidia-settings \
    lib32-nvidia-utils lib32-opencl-nvidia opencl-nvidia \
    libva-nvidia-driver vulkan-icd-loader lib32-vulkan-icd-loader egl-wayland
