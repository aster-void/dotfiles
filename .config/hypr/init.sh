if [ ! -f hardware-dep.conf ]; then 
  cp hardware-dep.conf.sample hardware-dep.conf
fi
if [ ! -f plugins.conf ]; then
  cp plugins.conf.sample plugins.conf
fi
if [ ! -f monitor.conf ]; then
  cp monitor.conf.sample monitor.conf
fi
if [ ! -f hyprpaper.conf ]; then
  cp hyprpaper.conf.sample hyprpaper.conf
fi
