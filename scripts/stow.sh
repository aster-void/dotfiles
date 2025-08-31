#!/usr/bin/env bash

set -euo pipefail
cd "$(dirname -- "$0")"

stow -R -d ../. -t ~ stow --adopt
