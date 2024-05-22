# My entire config

## clone
first clone nixos-config into /etc/nixos and run nixos-rebuild switch
then run this.

```shell
git clone git@github.com:aster-void/dotfiles.git ~/.dotfiles && ~/.dotfiles/init.sh
```

## Not to do

do not execute scripts that start with '.' (such as .init.sh).
they are intended to be called from other scripts.

## available apps

alacritty, hyprland, waybar, and all apps within home-manager and nixos-config.
