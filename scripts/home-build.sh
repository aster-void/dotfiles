#!/usr/bin/env bash
set -euo pipefail

git add -A -N
nh home build . --no-nom --quiet -- --quiet
