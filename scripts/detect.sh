#!/usr/bin/env bash
set -Eeuo pipefail
ROOT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd -P)
source "$ROOT_DIR/scripts/lib.sh"
detect_platform
printf 'OS=%s\nID=%s\nARCH=%s\nHyprland=%s\n' "$PRETTY_NAME" "$ID" "$ARCH" "$(command -v Hyprland || echo absent)"
