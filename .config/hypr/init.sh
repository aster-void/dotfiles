if [ ! -f hardware-dep.conf ]; then 
  cp hardware-dep.conf.sample hardware-dep.conf
fi
if [ ! -f plugins.conf ]; then
  cp plugins.conf.sample plugins.conf
fi
if [ ! -f monitors.hyprland.conf ]; then
  cp monitors.hyprland.conf.sample monitors.hyprland.conf
fi
if [ ! -f hyprpaper.conf ]; then
  cp hyprpaper.conf.sample hyprpaper.conf
fi
