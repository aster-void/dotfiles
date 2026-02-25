#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$(readlink -f "$0")")/.."

# Cache sudo credentials upfront and keep them alive in the background
sudo -v
while true; do sudo -v; sleep 60; done &
SUDO_KEEPALIVE_PID=$!
trap 'kill $SUDO_KEEPALIVE_PID 2>/dev/null' EXIT

if command -v dnf &>/dev/null; then
  echo "=== Updating DNF ==="
  sudo dnf upgrade --refresh -y

  echo ""
  echo "=== Updating Firmware ==="
  sudo fwupdmgr refresh --force
  sudo fwupdmgr update -y
  echo ""
fi

WARP_WAS_CONNECTED=0
if command -v warp-cli &>/dev/null && warp-cli status 2>/dev/null | grep -q "Connected"; then
  echo "=== Disconnecting from WARP ==="
  WARP_WAS_CONNECTED=1
  warp-cli disconnect
  echo ""
fi

echo "=== Updating Home Manager Flake ==="
nix flake update --flake ./home-manager

echo ""
echo "=== Updating NixOS Flake ==="
nix flake update --flake ./nixos

bash scripts/install.sh

if [[ "$WARP_WAS_CONNECTED" == "1" ]]; then
  echo ""
  echo "=== Reconnecting to WARP ==="
  warp-cli connect
fi

echo ""
echo "=== Updating Flatpak ==="
flatpak update -y

if command -v non-nixos-gpu-setup &>/dev/null; then
  echo ""
  echo "=== Installing GPU Drivers ==="
  sudo "$(command -v non-nixos-gpu-setup)"
  unit=/etc/systemd/system/non-nixos-gpu.service
  if [ -L "$unit" ]; then
    sudo cp --remove-destination "$(readlink -f "$unit")" "$unit"
    sudo systemctl daemon-reload
  fi
fi

echo ""
echo "=== All updates complete ==="
