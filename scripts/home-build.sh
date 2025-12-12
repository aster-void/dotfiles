#!/usr/bin/env bash
set -euo pipefail

git add -A -N

if [[ "${1:-}" == "--show-error" ]]; then
  home-manager build --flake . --show-trace
else
  nh home build . --no-nom --quiet -- --quiet
fi
