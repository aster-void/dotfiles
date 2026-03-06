#!/usr/bin/env bash
set -uo pipefail # -e flag omitted intentionally

cd "$(dirname "$(readlink -f "$0")")/.." || exit

# Generate gpu.nix with host's NVIDIA driver version (if applicable)
gpu_nix=home-manager/modules/gpu.nix
if command -v nvidia-smi &>/dev/null; then
  host_ver=$(nvidia-smi --query-gpu=driver_version --format=csv,noheader)
  current_ver=$(grep -oP 'version = "\K[^"]+' "$gpu_nix" 2>/dev/null || echo "")
  if [[ "$host_ver" != "$current_ver" ]]; then
    echo "=== Generating gpu.nix for NVIDIA $host_ver ==="
    hash=$(nix store prefetch-file \
      "https://download.nvidia.com/XFree86/Linux-x86_64/${host_ver}/NVIDIA-Linux-x86_64-${host_ver}.run" \
      2>&1 | grep -oP "hash '\K[^']+")
    cat > "$gpu_nix" <<EOF
{
  targets.genericLinux.gpu.nvidia = {
    enable = true;
    version = "$host_ver";
    sha256 = "$hash";
  };
}
EOF
    echo "Generated gpu.nix: version=$host_ver"
  else
    echo "gpu.nix is up to date
host = $host_ver
gpu.nix = $current_ver
"
  fi
fi

git add -A -N
# Use flake's own home-manager CLI; fall back to nix build + activate for bootstrap
if command -v home-manager &>/dev/null; then
  home-manager switch --flake ./home-manager --option warn-dirty false
else
  nix run home-manager/master -- switch --flake ./home-manager --option warn-dirty false
fi

# Set up GPU drivers in /run/opengl-driver (requires root, only when changed)
if command -v non-nixos-gpu-setup &>/dev/null; then
  setup_script=$(command -v non-nixos-gpu-setup)
  new_store_path=$(grep -oP '/nix/store/\S+-non-nixos-gpu' "$setup_script" | head -1)
  current_store_path=$(readlink /etc/systemd/system/non-nixos-gpu.service 2>/dev/null | grep -oP '/nix/store/\S+-non-nixos-gpu')
  if [[ "$new_store_path" != "$current_store_path" ]] || [[ ! -e /run/opengl-driver ]]; then
    echo "=== Updating GPU drivers in /run/opengl-driver ==="
    # restorecon: nix store files start as default_t; relabel to systemd_unit_file_t
    # so SELinux allows systemd to read the symlinked service file.
    sudo restorecon "$new_store_path/lib/systemd/system/non-nixos-gpu.service" 2>/dev/null || true
    sudo "$setup_script"
  fi
fi
set +u
. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" 2>/dev/null || true
set -u
export PATH="$HOME/.nix-profile/bin:$PATH"
if [[ ! -f dotter/local.toml ]]; then
  cat > dotter/local.toml <<'EOF'
includes = []
packages = ["default"]
EOF
fi
dotter -g dotter/global.toml -l dotter/local.toml --cache-file dotter/.cache.toml deploy -f -y

# Claude Code (native binary, auto-updates on startup)
if ! command -v claude &>/dev/null; then
  curl -fsSL https://claude.ai/install.sh | bash
fi

# Voxtype: download whisper model if voxtype is present
if command -v voxtype &>/dev/null; then
  voxtype setup --download --model large-v3-turbo --quiet
fi
