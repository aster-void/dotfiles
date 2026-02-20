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

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
FLAKE_DIR="$(dirname "$SCRIPT_DIR")"

git add -A -N

if [[ "$dry_run" == true ]]; then
	nixos-rebuild dry-build --flake "$FLAKE_DIR#$hostname" --quiet
else
	nixos-rebuild build --flake "$FLAKE_DIR#$hostname" --quiet
fi
