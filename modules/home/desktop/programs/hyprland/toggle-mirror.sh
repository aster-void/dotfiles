set -euo pipefail

PRIMARY="@primary@"

if [[ -z "$PRIMARY" ]]; then
  echo "No primary monitor configured"
  exit 1
fi

usage() {
  echo "Usage: toggle-mirror <on|off>"
  exit 1
}

[[ $# -ne 1 ]] && usage

case "$1" in
  on)
    hyprctl keyword monitor ",preferred,auto,1,mirror,${PRIMARY}"
    echo "Mirroring enabled"
    ;;
  off)
    hyprctl keyword monitor ",preferred,auto,1"
    echo "Mirroring disabled"
    ;;
  *)
    usage
    ;;
esac
