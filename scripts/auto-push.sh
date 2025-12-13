#!/usr/bin/env bash
cd "$(dirname -- "$0")/.." || exit 1
exec flock -n /tmp/dotfiles-push.lock git push
