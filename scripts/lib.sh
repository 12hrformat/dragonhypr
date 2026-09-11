#!/usr/bin/env bash
# DragonHyprland — created by Dragon. Shared helpers have no side effects when sourced.
DRAGON_VERSION="0.1.0"
CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
DRAGON_CONFIG="$CONFIG_HOME/dragonhyprland"
DRAGON_STATE="$STATE_HOME/dragonhyprland"
log() { printf '[dragonhyprland] %s\n' "$*"; }
warn() { printf '[dragonhyprland] warning: %s\n' "$*" >&2; }
die() { printf '[dragonhyprland] error: %s\n' "$*" >&2; exit 1; }
require_command() { command -v "$1" >/dev/null 2>&1 || die "Required command not found: $1"; }
require_not_root() { [[ ${EUID:-$(id -u)} -ne 0 ]] || die 'Run as your regular desktop user; sudo is requested only when needed.'; }
detect_platform() {
  [[ -r /etc/os-release ]] || die 'Cannot read /etc/os-release.'
  # shellcheck disable=SC1091
  source /etc/os-release
  ARCH=$(dpkg --print-architecture 2>/dev/null || uname -m)
}
require_supported_platform() {
  case "${ID:-}" in kali|debian) ;; *) die "Unsupported OS: ${PRETTY_NAME:-unknown}. DragonHyprland supports Kali and Debian derivatives.";; esac
}
timestamp() { date '+%Y-%m-%d_%H-%M-%S'; }
backup_root() { printf '%s/backups' "$DRAGON_CONFIG"; }
safe_link() { local source=$1 target=$2; mkdir -p "$(dirname "$target")"; rm -f "$target"; ln -s "$source" "$target"; }
