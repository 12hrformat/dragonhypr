#!/usr/bin/env bash
# Restore a chosen DragonHyprland backup. Existing paths are backed up first.
set -Eeuo pipefail
ROOT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd -P)
source "$ROOT_DIR/scripts/lib.sh"
backup=${1:-}
if [[ -z $backup ]]; then
  backup=$(find "$(backup_root)" -mindepth 1 -maxdepth 1 -type d -printf '%f\n' 2>/dev/null | sort | tail -n1 || true)
  [[ -n $backup ]] && backup="$(backup_root)/$backup"
elif [[ $backup != /* ]]; then backup="$(backup_root)/$backup"; fi
[[ -d $backup ]] || die 'No backup found. Supply a timestamp or absolute backup path.'
"$ROOT_DIR/scripts/backup.sh" --automatic
while IFS= read -r -d '' item; do
  relative=${item#"$backup/"}; target="$CONFIG_HOME/$relative"
  rm -rf -- "$target"
  mkdir -p "$(dirname "$target")"
  cp -a -- "$item" "$target"
done < <(find "$backup" -mindepth 1 -maxdepth 1 -print0)
log "Restored $backup. Restart Hyprland to apply changes."
