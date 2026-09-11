#!/usr/bin/env bash
set -Eeuo pipefail
ROOT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd -P)
source "$ROOT_DIR/scripts/lib.sh"
status=0
check_command() { if command -v "$2" >/dev/null 2>&1; then printf '✓ %-22s %s\n' "$1" "$(command -v "$2")"; else printf '✗ %-22s Install package: %s\n' "$1" "$3"; status=1; fi; }
detect_platform
printf '✓ %-22s %s (%s)\n' 'Operating system' "$PRETTY_NAME" "$ARCH"
[[ ${ID:-} == kali || ${ID:-} == debian ]] || { printf '✗ %-22s Unsupported OS\n' 'Operating system'; status=1; }
check_command Hyprland Hyprland hyprland
check_command Waybar waybar waybar
check_command Terminal kitty kitty
check_command Launcher rofi rofi
check_command Notifications swaync swaync
check_command Wallpaper hyprpaper hyprpaper
check_command Locker hyprlock hyprlock
check_command Idle hypridle hypridle
check_command Screenshot grim grim
check_command Clipboard wl-paste wl-clipboard
check_command Audio-control wpctl wireplumber
[[ -r "$CONFIG_HOME/hypr/hyprland.conf" ]] && printf '✓ %-22s %s\n' 'Hyprland config' "$CONFIG_HOME/hypr/hyprland.conf" || { printf '✗ %-22s Run dragonhyprland install\n' 'Hyprland config'; status=1; }
[[ ${XDG_SESSION_TYPE:-} == wayland ]] && printf '✓ %-22s Wayland\n' 'Session' || printf '! %-22s Not currently a Wayland session\n' 'Session'
[[ -n ${HYPRLAND_INSTANCE_SIGNATURE:-} ]] && printf '✓ %-22s Connected\n' 'Hyprland environment' || printf '! %-22s Start/restart Hyprland to test\n' 'Hyprland environment'
exit "$status"
