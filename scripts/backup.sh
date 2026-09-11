#!/usr/bin/env bash
# Archives only paths DragonHyprland may manage; never overwrites an existing backup.
set -Eeuo pipefail
ROOT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd -P)
source "$ROOT_DIR/scripts/lib.sh"
destination="$(backup_root)/$(timestamp)"
mkdir -p "$destination"
paths=(hypr waybar kitty rofi swaync hyprpaper.conf hyprlock.conf hypridle.conf gtk-3.0/settings.ini gtk-4.0/settings.ini qt5ct qt6ct)
for item in "${paths[@]}"; do
  source_path="$CONFIG_HOME/$item"
  [[ -e $source_path || -L $source_path ]] || continue
  mkdir -p "$destination/$(dirname "$item")"
  cp -a -- "$source_path" "$destination/$item"
done
printf '%s\n' "$destination" > "$DRAGON_STATE/last-backup" 2>/dev/null || { mkdir -p "$DRAGON_STATE"; printf '%s\n' "$destination" > "$DRAGON_STATE/last-backup"; }
log "Backup created at $destination"
