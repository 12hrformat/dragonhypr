#!/usr/bin/env bash
# Installs project-owned files in XDG locations. A manifest makes removal precise.
set -Eeuo pipefail
ROOT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd -P)
source "$ROOT_DIR/scripts/lib.sh"
manifest="$DRAGON_STATE/managed-paths"
mkdir -p "$DRAGON_STATE" "$CONFIG_HOME" "$DATA_HOME/dragonhyprland"
: > "$manifest"
for directory in hypr waybar kitty rofi swaync gtk-3.0 gtk-4.0 qt5ct qt6ct; do
  target="$CONFIG_HOME/$directory"
  rm -rf -- "$target"
  cp -a "$ROOT_DIR/config/$directory" "$target"
  printf '%s\n' "$target" >> "$manifest"
done
for file in hyprpaper.conf hyprlock.conf hypridle.conf; do
  cp -a "$ROOT_DIR/config/$file" "$CONFIG_HOME/$file"
  printf '%s\n' "$CONFIG_HOME/$file" >> "$manifest"
done
mkdir -p "$DATA_HOME/dragonhyprland"
cp -a "$ROOT_DIR/themes" "$ROOT_DIR/wallpapers" "$DATA_HOME/dragonhyprland/"
printf '%s\n' "$DATA_HOME/dragonhyprland" >> "$manifest"
mkdir -p "$HOME/.local/bin"
safe_link "$ROOT_DIR/bin/dragonhyprland" "$HOME/.local/bin/dragonhyprland"
printf '%s\n' "$HOME/.local/bin/dragonhyprland" >> "$manifest"
log 'Configuration deployed. Existing managed configuration is preserved in the pre-install backup.'
