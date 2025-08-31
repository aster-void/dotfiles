#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname -- "$0")"

(
  cd hyprland
  cp -n samples/hardware-dep.conf hardware-dep.conf
  cp -n samples/plugins.conf plugins.conf
)
