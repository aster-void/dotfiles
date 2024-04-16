if [ ! -f hardware-dep.conf ]; then 
  cp hardware-dep.conf.sample hardware-dep.conf
fi
if [ ! -f plugins.conf ]; then
  cp plugins.conf.sample plugins.conf
fi
