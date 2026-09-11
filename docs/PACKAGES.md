# Package strategy

Package names are not treated as immutable facts. The canonical package lists live in `scripts/packages.sh`, and `apt-cache show` tests every item against the exact system about to be changed. Required items must all resolve; optional items are installed only when resolvable. This makes differences between Kali rolling and a Debian release explicit at install time, without repository mutation or silent feature loss.

Current component mapping: `hyprland` (compositor), `waybar` (bar), `kitty` (terminal), `rofi` (launcher), `sway-notification-center` (the `swaync` command), `hyprpaper` (wallpaper), `hyprlock` (lock), `hypridle` (idle), `grim`/`slurp` (screenshot), `wl-clipboard`/`cliphist` (clipboard), and `thunar` (file manager). The portal packages enable desktop integration and `qt5ct`/`qt6ct`, Papirus, and JetBrains Mono provide appearance defaults.
