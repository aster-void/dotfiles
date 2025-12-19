#!/usr/bin/env bash
set -euo pipefail

dry_run=false
hostname="$(hostname)"

for arg in "$@"; do
	case "$arg" in
	--dry) dry_run=true ;;
	*) hostname="$arg" ;;
	esac
done

git add -A -N

if [[ "$dry_run" == true ]]; then
	nixos-rebuild build --flake ".#$hostname" --dry-run
else
	nixos-rebuild build --flake ".#$hostname"
fi
