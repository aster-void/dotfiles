#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$(readlink -f "$0")")/.."

# Cache sudo credentials upfront and keep them alive in the background
sudo -v
while true; do sudo -v; sleep 60; done &
SUDO_KEEPALIVE_PID=$!
trap 'kill $SUDO_KEEPALIVE_PID 2>/dev/null' EXIT

# --- DNF repos ---
echo "=== Enabling COPR repositories ==="
if ! dnf repolist | grep -q "alternateved.*keyd"; then
  sudo dnf copr enable -y alternateved/keyd
fi
if ! dnf repolist | grep -q "wezfurlong.*wezterm"; then
  sudo dnf copr enable -y wezfurlong/wezterm-nightly
fi

# --- DNF packages ---
echo "=== Installing DNF packages ==="
sudo dnf install -y fish fuse-libs ghostty keyd wezterm

# --- User groups ---
echo ""
echo "=== Setting up user groups ==="
# input group: needed for voxtype evdev hotkey detection
if ! groups "$USER" | grep -qw input; then
  sudo usermod -aG input "$USER"
  echo "Added $USER to input group (re-login required)"
fi

# --- Shell setup ---
echo ""
echo "=== Setting up shell ==="
FISH_PATH=/usr/bin/fish
if ! grep -qx "$FISH_PATH" /etc/shells; then
  echo "$FISH_PATH" | sudo tee -a /etc/shells >/dev/null
fi
if [ "$SHELL" != "$FISH_PATH" ]; then
  sudo chsh -s "$FISH_PATH" "$USER"
fi

# --- /etc file deployment ---
echo ""
echo "=== Deploying /etc files ==="

MANIFEST="/etc/.home-config-managed"
current_files=$(cd etc && find . -type f | sed 's|^\./||' | sort)

if [[ -f "$MANIFEST" ]]; then
  while IFS= read -r old_file; do
    if ! echo "$current_files" | grep -qxF "$old_file"; then
      echo "Removing deleted file: /etc/$old_file"
      sudo rm -f "/etc/$old_file"
    fi
  done < "$MANIFEST"
fi

while IFS= read -r file; do
  sudo install -D -m 644 -o root -g root "etc/$file" "/etc/$file"
done <<< "$current_files"
sudo chmod 600 /etc/ssh/sshd_config

echo "$current_files" | sudo tee "$MANIFEST" > /dev/null

echo "Enabling services..."
sudo systemctl enable --now sshd avahi-daemon keyd

echo "Restarting sshd..."
sudo sshd -t && sudo systemctl restart sshd

echo "Reloading sysctl..."
sudo sysctl --system > /dev/null

# --- Tailscale ---
echo ""
echo "=== Installing Tailscale ==="
if ! dnf repolist | grep -q tailscale; then
  sudo dnf config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo
fi
sudo dnf install -y tailscale
sudo systemctl enable --now tailscaled

# --- Cloudflare WARP ---
echo ""
echo "=== Installing Cloudflare WARP ==="
sudo dnf install -y cloudflare-warp

# Disconnect WARP during setup to avoid GitHub API rate limits on shared IPs
WARP_WAS_CONNECTED=false
if command -v warp-cli &>/dev/null && warp-cli status 2>/dev/null | grep -q "Connected"; then
  WARP_WAS_CONNECTED=true
  warp-cli --accept-tos disconnect
fi

# --- Claude Desktop ---
if ! flatpak run it.mijorus.gearlever --list-installed 2>/dev/null | grep -qi claude; then
  echo ""
  echo "=== Installing Claude Desktop (AppImage via GearLever) ==="
  APPIMAGE_URL=$(curl -fsSL https://api.github.com/repos/aaddrick/claude-desktop-debian/releases/latest \
    | jq -r '.assets[] | select(.name | test("amd64\\.AppImage$")) | .browser_download_url')
  if [ -z "$APPIMAGE_URL" ]; then
    echo "Warning: Could not find Claude Desktop AppImage release. Skipping."
  else
    TMPFILE=$(mktemp --suffix=.AppImage)
    curl -fL "$APPIMAGE_URL" -o "$TMPFILE"
    chmod +x "$TMPFILE"
    (yes || true) | flatpak run it.mijorus.gearlever --integrate "$TMPFILE"
    rm -f "$TMPFILE"
    echo "Claude Desktop integrated via GearLever."
  fi
fi

# --- GPU drivers ---
if command -v non-nixos-gpu-setup &>/dev/null; then
  echo ""
  echo "=== Setting up non-NixOS GPU compatibility ==="
  # restorecon: nix store files start as default_t; relabel to systemd_unit_file_t
  # so SELinux allows systemd to read the symlinked service file.
  setup_script=$(command -v non-nixos-gpu-setup)
  store_path=$(grep -oP '/nix/store/\S+-non-nixos-gpu' "$setup_script" | head -1)
  sudo restorecon "$store_path/lib/systemd/system/non-nixos-gpu.service" 2>/dev/null || true
  sudo "$setup_script"
fi

# --- Reconnect Cloudflare WARP ---
if ! warp-cli registration show &>/dev/null; then
  warp-cli --accept-tos registration new
fi
warp-cli --accept-tos connect
echo "WARP connected."

echo ""
echo "=== System installation complete ==="
