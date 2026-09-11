# Design notes

DragonHyprland uses a deliberately conservative boundary: system packages are managed by APT, and the framework manages only named XDG paths. `scripts/deploy.sh` records every path it creates in a manifest; `scripts/uninstall.sh` refuses to act without that manifest. Every install first makes a timestamped configuration backup.

The deployment is intentionally copy-based rather than a live symlink farm. A working desktop remains usable if the repository is moved or removed. The CLI itself is symlinked into `~/.local/bin` for convenience and its link is recorded in the same manifest.

Hyprland hardware handling begins from the portable `monitor = ,preferred,auto,1` default. Optional desktop modules may be absent: Waybar handles battery and Bluetooth hardware conditionally, and its VPN module is read-only and becomes empty without an active NetworkManager VPN.
