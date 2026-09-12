# DragonHyprland
#### kali-linux hyprland config files

> Created by 12hrformat. Built for Kali linux users who want a aesthetic Hyprland desktop—not a disposable rice.

> under development, please expect bugs and glitches because making hyprland config on kali is a pain

DragonHyprland is an independent, Kali Linux–first Hyprland desktop setup framework, inspired by https://github.com/mylinuxforwork

It deliberately leaves APT source configuration untouched. Every required package is checked with `apt-cache show` against the repositories already configured on the target before installation; an unavailable required package stops the install with a clear report.

## Architecture

| Layer | Responsibility |
| --- | --- |
| `install.sh` | Interactive, idempotent orchestration and privilege disclosure |
| `scripts/` | OS detection, APT plan, deployment, backup/restore, diagnostics, uninstall |
| `config/` | Modular application configuration copied to XDG config locations |
| `themes/` | Small, switchable Hyprland + Waybar color layers |
| `bin/dragonhyprland` | Stable, user-facing management command |

`config/hypr/hyprland.conf` is intentionally a small entry point. Each concern is in its own sourced file, and `local.conf` is reserved for machine-specific changes.

## Supported systems

Primary target: Kali rolling on a supported Debian architecture. Debian is accepted as a best-effort target, provided every required package is available from its configured repositories. The installer checks `/etc/os-release` and `dpkg --print-architecture`; it does not use Arch tooling or add repositories.

## Components

Hyprland, Waybar, Kitty, Firefox ESR, Rofi, SwayNotificationCenter, Hyprpaper, Hyprlock, Hypridle, Grim/Slurp, wl-clipboard/Cliphist, Thunar, portals, Qt appearance tools, Papirus icons, and JetBrains Mono are required. Bluetooth, brightness, audio UI, media control, NetworkManager tray integration (`network-manager-applet`), Hyprland's PolicyKit agent (`hyprpolkitagent`), and emoji fonts are optional when found in the current APT metadata.

The bar includes workspace, clock, CPU, RAM, disk, battery (hidden naturally when unsupported), network, audio, Bluetooth, VPN status, and tray. The VPN indicator queries active NetworkManager connections only; it never changes a VPN connection.

## Quick Install
```
curl -fsSL https://raw.githubusercontent.com/12hrformat/dragonhypr/main/meow.sh | bash
```

## Install

```bash
git clone https://github.com/12hrformat/dragonhypr.git
cd dragonhypr
chmod +x install.sh update.sh uninstall.sh bin/dragonhyprland scripts/*.sh
./install.sh
```

Before any user configuration changes, a timestamped copy is made at `~/.config/dragonhyprland/backups/`. The installer only uses `sudo` for `apt-get update` and `apt-get install`; it prints this before asking for confirmation. It never changes `/etc/apt/sources.list`.

## Daily management

```bash
dragonhyprland doctor
dragonhyprland theme list
dragonhyprland theme set dragon-yellow
dragonhyprland backup
dragonhyprland restore 2026-09-11_12-30-00
dragonhyprland update
dragonhyprland uninstall --restore
dragonhyprland welcome --reset
```

`uninstall` removes only paths recorded in its deployment manifest and intentionally leaves APT packages installed. `--restore` restores the backup recorded immediately before the first installation.

## First-run welcome

On its first Hyprland startup, DragonHyprland shows a welcome dialog with the essential shortcuts. The user can keep the full welcome screen on every startup, show shortcuts only, save a shortcut sheet to `~/Documents`, or disable it. Re-enable the full welcome screen at any time with `dragonhyprland welcome --reset`.

## Theme and wallpaper system

The default black-and-yellow theme uses yellow as an accent. `monochrome` is included as an alternative. A custom theme is a pair of `theme.conf` (Hyprland) and `waybar.css` (Waybar). Wallpapers are user-extensible and the only bundled artwork is an original CC0 placeholder; replace it with an appropriately licensed image.

## Troubleshooting

Run `dragonhyprland doctor` first. If installation reports a missing package, refresh only your normal repository metadata (`sudo apt-get update`) and re-run the plan. Do not add third-party repositories merely to satisfy this project. On systems without NetworkManager, the VPN indicator simply stays empty. Add monitor-specific configuration to `~/.config/hypr/local.conf`.

## Screenshots

Add screenshots of your own configured environment here before publishing. This repository does not bundle third-party artwork or screenshots.

## Contributing and license

See [CONTRIBUTING.md](CONTRIBUTING.md). DragonHyprland is distributed under the MIT license.
