#!/usr/bin/env bash
REPO_DIR="$(cd "$(dirname -- "$0")/.." && pwd)"
exec systemd-run --user --no-block --working-directory="$REPO_DIR" \
  bash -c "flock -n '$REPO_DIR/.git/push.lock' git push && sleep 5 && comin fetch"
