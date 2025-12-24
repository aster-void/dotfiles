#!/usr/bin/env bash
# Wake machines via Tailscale + relay
# Usage: wol <hostname>

set -euo pipefail

declare -A TARGETS=(
    # [target]="mac|relay"
    [azalea]="fc:34:97:0c:bb:fb|bluebell"
)

usage() {
    echo "Usage: wol <hostname>"
    echo "Available targets: ${!TARGETS[*]}"
    exit 1
}

[[ $# -eq 1 ]] || usage

TARGET="$1"
[[ -v TARGETS[$TARGET] ]] || { echo "Unknown target: $TARGET"; usage; }

IFS='|' read -r MAC RELAY <<< "${TARGETS[$TARGET]}"

echo "Waking $TARGET ($MAC) via $RELAY..."
ssh "$RELAY" "wakeonlan $MAC || wol $MAC"
echo "Done."
