#!/usr/bin/env bash
# Resolve candidates against the machine's current configured APT metadata.
set -Eeuo pipefail
ROOT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd -P)
source "$ROOT_DIR/scripts/lib.sh"
required=(hyprland waybar kitty rofi sway-notification-center hyprpaper hyprlock hypridle grim slurp wl-clipboard cliphist thunar wireplumber xdg-desktop-portal xdg-desktop-portal-hyprland qt5ct qt6ct papirus-icon-theme fonts-jetbrains-mono)
optional=(blueman brightnessctl pavucontrol playerctl network-manager-gnome polkitd-gnome noto-fonts-color-emoji)
available=() missing=()
resolve() { apt-cache show "$1" >/dev/null 2>&1; }
plan() {
  available=(); missing=()
  for pkg in "${required[@]}"; do resolve "$pkg" && available+=("$pkg") || missing+=("$pkg"); done
  printf 'Required desktop packages available:\n'; printf '  %s\n' "${available[@]}"
  if ((${#missing[@]})); then printf 'Unavailable required packages (installation will stop):\n' >&2; printf '  %s\n' "${missing[@]}" >&2; return 1; fi
  printf 'Optional, installed only if available:\n'; for pkg in "${optional[@]}"; do resolve "$pkg" && printf '  %s\n' "$pkg"; done
}
install() {
  require_command sudo
  sudo apt-get update
  plan
  local optional_available=() pkg
  for pkg in "${optional[@]}"; do resolve "$pkg" && optional_available+=("$pkg"); done
  sudo apt-get install --yes "${available[@]}" "${optional_available[@]}"
}
case ${1:-plan} in plan) plan;; install) install;; *) die 'Usage: packages.sh {plan|install}';; esac
