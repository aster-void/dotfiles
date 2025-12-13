#!/usr/bin/env bash
REPO_DIR="$(cd "$(dirname -- "$0")/.." && pwd)"
exec systemd-run --user --no-block --working-directory="$REPO_DIR" \
  flock -n /tmp/dotfiles-push.lock git push
