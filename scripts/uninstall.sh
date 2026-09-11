#!/usr/bin/env bash
# Removes only the paths recorded at deployment. It never removes APT packages.
set -Eeuo pipefail
ROOT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd -P)
source "$ROOT_DIR/scripts/lib.sh"
manifest="$DRAGON_STATE/managed-paths"
[[ -f $manifest ]] || die 'No managed-path manifest found; refusing to guess what to remove.'
"$ROOT_DIR/scripts/backup.sh" --automatic
while IFS= read -r path; do
  [[ -n $path ]] || continue
  case "$path" in "$CONFIG_HOME"/*|"$DATA_HOME"/*|"$HOME/.local/bin/dragonhyprland") rm -rf -- "$path";; *) die "Unsafe manifest path: $path";; esac
done < "$manifest"
rm -f -- "$manifest"
if [[ ${1:-} == --restore ]]; then
  [[ -f $DRAGON_STATE/install-backup ]] || die 'The original install backup is not recorded; use scripts/restore.sh with a backup timestamp.'
  "$ROOT_DIR/scripts/restore.sh" "$(<"$DRAGON_STATE/install-backup")"
fi
log 'DragonHyprland files removed. APT packages were intentionally left installed.'
