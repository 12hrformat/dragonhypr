#!/usr/bin/env bash
# DragonHyprland installer. Safe to run again: configuration is backed up first.
set -Eeuo pipefail
IFS=$'\n\t'

ROOT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
# shellcheck source=scripts/lib.sh
source "$ROOT_DIR/scripts/lib.sh"

main() {
  require_not_root
  detect_platform
  require_supported_platform
  require_command apt-get
  require_command apt-cache
  require_command sudo
  printf '%s\n' "DragonHyprland $DRAGON_VERSION" "Target: $PRETTY_NAME ($ARCH)" ""
  "$ROOT_DIR/scripts/packages.sh" plan
  printf '\nThis will use sudo only for: apt-get update/install. It will not edit APT sources.\n'
  if [[ ${DRAGON_ASSUME_YES:-0} != 1 ]]; then
    read -r -p 'Continue? [y/N] ' answer
    [[ $answer =~ ^[Yy]([Ee][Ss])?$ ]] || { echo 'Cancelled.'; exit 0; }
  fi
  backup_path=$("$ROOT_DIR/scripts/backup.sh" --automatic | sed -n 's/.*Backup created at //p' | tail -n1)
  mkdir -p "$DRAGON_STATE"
  [[ -f $DRAGON_STATE/install-backup ]] || printf '%s\n' "$backup_path" > "$DRAGON_STATE/install-backup"
  "$ROOT_DIR/scripts/packages.sh" install
  "$ROOT_DIR/scripts/deploy.sh"
  "$ROOT_DIR/scripts/doctor.sh" --post-install || true
  cat <<EOF

Installation complete.
  Start a Hyprland session from your display manager, or run Hyprland from a TTY.
  Manage this installation: dragonhyprland doctor | theme list | backup
  Backup location: ${XDG_CONFIG_HOME:-$HOME/.config}/dragonhyprland/backups
EOF
}
main "$@"
