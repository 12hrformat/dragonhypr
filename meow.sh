```bash
#!/usr/bin/env bash

clear

cat <<'EOF'
██████╗ ██████╗  █████╗  ██████╗  ██████╗ ███╗   ██╗
██╔══██╗██╔══██╗██╔══██╗██╔════╝ ██╔═══██╗████╗  ██║
██║  ██║██████╔╝███████║██║  ███╗██║   ██║██╔██╗ ██║
██║  ██║██╔══██╗██╔══██║██║   ██║██║   ██║██║╚██╗██║
██████╔╝██║  ██║██║  ██║╚██████╔╝╚██████╔╝██║ ╚████║
╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝

             D R A G O N H Y P R L A N D
                 Kali Linux • Hyprland
EOF

echo
echo ">>> Welcome to DragonHyprland."
echo ">>> Preparing your desktop..."
echo

git clone https://github.com/12hrformat/dragonhypr.git

cd dragonhypr

chmod +x install.sh update.sh uninstall.sh bin/dragonhyprland scripts/*.sh

./install.sh

