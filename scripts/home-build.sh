#!/usr/bin/env bash
set -euo pipefail

hostname="${1:-$(hostname)}"

git add -A -N
nh home build . --hostname "$hostname" --no-nom --quiet -- --quiet
