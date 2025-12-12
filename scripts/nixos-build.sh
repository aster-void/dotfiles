#!/usr/bin/env bash
set -euo pipefail

show_error=false
hostname="$(hostname)"

for arg in "$@"; do
  case "$arg" in
    --show-error) show_error=true ;;
    *) hostname="$arg" ;;
  esac
done

git add -A -N

if [[ "$show_error" == true ]]; then
  nixos-rebuild build --flake ".#$hostname" --show-trace
else
  nh os build . --hostname "$hostname" --no-nom --quiet -- --quiet
fi
