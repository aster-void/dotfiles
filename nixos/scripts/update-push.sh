#!/usr/bin/env bash
set -euo pipefail

input="${1:-}"

if [[ -n "$input" ]]; then
  nix flake update "$input"
  git add flake.lock
  git commit -m "flake: update input $input"
else
  nix flake update
  git add flake.lock
  git commit -m "flake: update inputs"
fi

git push --no-verify
