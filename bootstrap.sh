#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/aster-void/home-config.git"
DEST="$HOME/workspace/github.com/aster-void/home-config"

sudo -v

if ! command -v git &>/dev/null; then
  echo "Error: git is not installed." >&2
  exit 1
fi

if ! command -v nix &>/dev/null; then
  echo "Installing Determinate Nix..."
  curl -fsSL https://install.determinate.systems/nix | sh -s -- install --no-confirm
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi

if [ -d "$DEST/.git" ]; then
  echo "Repo already exists at $DEST, pulling latest..."
  git -C "$DEST" pull --ff-only
else
  echo "Cloning $REPO_URL to $DEST..."
  git clone "$REPO_URL" "$DEST"
fi

cd "$DEST"

read -rp "Is this a desktop setup? (y/N): " answer </dev/tty

bash scripts/install.sh

if [[ "$answer" =~ ^[Yy]$ ]]; then
  bash scripts/install_system.sh
fi

echo ""
echo "=== TODO ==="
echo "- Change hostname: sudo hostnamectl set-hostname <name>"
echo "- Log in to Tailscale: sudo tailscale up"
