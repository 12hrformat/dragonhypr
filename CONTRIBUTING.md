# Contributing

Keep changes Kali/Debian-first, modular, and ShellCheck-clean. Do not add APT sources or assume Arch packages. Package additions must be validated against Kali package metadata and guarded by `apt-cache` in `scripts/packages.sh`. Keep user configuration reversible and add a doctor check when introducing a required runtime binary.

Test with `bash -n install.sh bin/dragonhyprland scripts/*.sh` and run `shellcheck` when available. Changes that touch deployment must preserve the manifest and backup guarantees.
