#!/usr/bin/env bash
exec flock -n /tmp/dotfiles-push.lock git push
