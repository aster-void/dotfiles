cd $(dirname -- $0)

(
  cd hyprland;
  if [ ! -f hardware-dep.conf ]; then
    cp samples/hardware-dep.conf hardware-dep.conf
  fi
  if [ ! -f plugins.conf ]; then
    cp samples/plugins.conf plugins.conf
  fi
)

if [ ! -f hyprpaper.conf ]; then
  cp samples/hyprpaper.conf hyprpaper.conf
fi
