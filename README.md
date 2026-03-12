# dotfiles

<div align="center">

![OS](https://img.shields.io/badge/OS-CachyOS%20%7C%20Arch-blue?style=flat&logo=archlinux&logoColor=white)
![WM](https://img.shields.io/badge/WM-Hyprland-cyan?style=flat&logo=wayland&logoColor=white)
![Theme](https://img.shields.io/badge/Theme-Catppuccin%20Mocha-pink?style=flat&logoColor=white)
![Shell](https://img.shields.io/badge/Shell-Zsh-green?style=flat&logo=gnubash&logoColor=white)
![Terminal](https://img.shields.io/badge/Terminal-Kitty-orange?style=flat&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-yellow?style=flat)

Personal dotfiles for a Hyprland + CachyOS setup with Catppuccin Mocha theming.
Includes a full installer that handles packages, services, symlinks, and shell setup.

</div>

---

## 📋 Overview

- **Distro:** CachyOS Linux (Arch-based)
- **Window Manager:** Hyprland (Wayland)
- **Theme:** Catppuccin Mocha
- **Terminal:** Kitty
- **Shell:** Zsh + Starship prompt

---

## 📸 Screenshot

> 📸 Screenshots coming soon

---

## 📁 What's Included

| Path | Description |
|------|-------------|
| `.zshrc` | Zsh config — plugins (syntax-highlighting, autosuggestions, nvm), aliases, exports for Android SDK and vcpkg, editor set to vim |
| `.zshenv` | Forces `STARSHIP_CONFIG` path on every shell invocation |
| `.config/starship.toml` | Custom Starship prompt — two-line layout, git status, language versions, battery, command duration, OS icon |
| `.config/hypr/` | Hyprland and Hyprpaper configs plus helper scripts |
| `.config/kitty/` | Kitty terminal with Catppuccin Mocha theme |
| `.config/waybar/` | Waybar config and CSS stylesheet |
| `.config/nwg-dock-hyprland/` | Dock config for nwg-dock |
| `.config/gtk-3.0/` `.config/gtk-4.0/` | GTK theme settings for both GTK3 and GTK4 |
| `.scripts/` | Custom shell scripts (`toggle-dock`, `increase_volume`, etc.) |
| `install.sh` | Full installer — paru, packages, systemd services, config symlinks, default shell |

---

## 🚀 Installation

```bash
git clone https://github.com/ThiagoSantosOFC/dotfiles.git
cd dotfiles
chmod +x install.sh
./install.sh
```

The installer will:

1. Install `paru` (AUR helper) if not already present
2. Install all packages listed below via `paru`
3. Enable required systemd services (PipeWire, Bluetooth, NetworkManager)
4. Symlink all configs to their correct locations under `~/.config`
5. Set Zsh as the default shell

---

## 📦 Package Groups

| Group | Packages |
|-------|----------|
| 🐚 **Shell & Terminal** | zsh, starship, kitty, fastfetch, btop, duf, ripgrep, tree, micro, vim |
| 🪟 **Hyprland** | hyprland, hyprpaper, hyprpicker, hyprshot, hyprexpose, hyprpanel, nwg-dock, waybar, swaync, wofi, dunst |
| 🔊 **Audio** | PipeWire full stack, pavucontrol |
| 🔵 **Bluetooth** | bluez, blueman |
| 🎮 **NVIDIA** | nvidia-open-dkms full stack, Vulkan, VA-API |
| 🔤 **Fonts** | JetBrains Mono Nerd, Cascadia Code Nerd, FiraCode Nerd, Meslo Nerd, Noto, Nerd Fonts symbols |
| 🎨 **Theme** | Catppuccin Mocha GTK, Kvantum + Catppuccin, Papirus icons, qt5ct/qt6ct |
| 🖥️ **Apps** | Brave, Firefox, Librewolf, VSCode, Kate, Dolphin, MPV, Steam, ProtonUp-Qt, OpenRGB, Flameshot, Satty, Flatpak |
| 🛠️ **Dev** | git, gh, nodejs, npm, yarn, nvm, python, pip, pipx, JDK, maven, php |

---

## 📝 Notes

- **CachyOS-specific** — Some packages come from CachyOS repos and may not be available on vanilla Arch. Running the installer on plain Arch may require manual adjustments to the package list.
- **NVIDIA** — The NVIDIA stack is included by default. Skip that block in `install.sh` if you're on AMD or Intel.
- **Symlinks** — Configs are symlinked, not copied. Changes in the cloned repo are reflected immediately.
- **Backup** — Existing configs at target paths are automatically backed up to `~/.dotfiles-backup-<timestamp>` before being replaced.

---

## 📄 License

MIT — do whatever you want with it.
