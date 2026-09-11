#!/usr/bin/env bash
# First-run/startup guide. Preferences live in XDG state, never in the repository.
set -Eeuo pipefail
ROOT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd -P)
source "$ROOT_DIR/scripts/lib.sh"

shortcuts=$(cat <<'EOF'
Super + Return   Open Kitty terminal
Super + D        Application launcher
Super + Q        Close focused window
Super + F        Toggle fullscreen
Super + V        Toggle floating window
Super + L        Lock screen
Super + Shift + S  Area screenshot → clipboard
Super + C        Clipboard history
Super + 1–4      Switch workspace
Super + Shift + 1–4  Move window to workspace
EOF
)

state_file="$DRAGON_STATE/welcome-mode"
if [[ ${1:-} == --reset ]]; then
  mkdir -p "$DRAGON_STATE"
  printf 'full\n' > "$state_file"
  exit 0
fi
mode=full
[[ -r $state_file ]] && mode=$(<"$state_file")
[[ $mode == disabled ]] && exit 0

save_shortcuts() {
  local destination="${XDG_DOCUMENTS_DIR:-$HOME/Documents}/DragonHyprland-shortcuts.txt"
  mkdir -p "$(dirname "$destination")"
  printf 'DragonHyprland shortcuts\n========================\n\n%s\n' "$shortcuts" > "$destination"
  zenity --info --title='DragonHyprland' --text="Shortcut sheet saved to:\n$destination" --width=460
}

if [[ $mode == shortcuts ]]; then
  message="DragonHyprland shortcuts\n\n$shortcuts"
else
  message="Thanks for installing DragonHyprland.\n\nYour Kali-first Hyprland desktop is ready.\n\n$shortcuts"
fi

choice=$(zenity --list --radiolist --title='Welcome to DragonHyprland' \
  --text="$message" --column='' --column='Startup preference' \
  --width=760 --height=520 --hide-header \
  TRUE 'Keep showing this welcome screen' \
  FALSE 'Show only shortcuts at startup' \
  FALSE 'Save shortcuts to Documents' \
  FALSE 'Do not show this screen again') || exit 0

mkdir -p "$DRAGON_STATE"
case $choice in
  'Keep showing this welcome screen') printf 'full\n' > "$state_file" ;;
  'Show only shortcuts at startup') printf 'shortcuts\n' > "$state_file" ;;
  'Save shortcuts to Documents') save_shortcuts ;;
  'Do not show this screen again') printf 'disabled\n' > "$state_file" ;;
esac
