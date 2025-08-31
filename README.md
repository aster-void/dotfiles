# My entire config

## WARNING

I don't maintain the files nor the docs very often, so many things may be left outdated.
Also many apps are configured just for me, such as keyboard layout. (I use workman btw)
This repo is open just for reference, and is not intended to be used out of the box.

## bootstrapping 

1. clone

```sh
git clone --recursive git@github.com:aster-void/dotfiles.git ~/.dotfiles
```

2. run home-manager via nix run

```sh
nix run github:nix-community/home-manager -- switch --flake .#amberwood # your favorite flavor
```

## available apps

alacritty, hyprland, waybar, and all apps within home-manager and nixos-config.

## Before running

Read flake.nix and search for personal settings.

# Licenses

the part where I created is licensed under WTFPL. i.e. you can do what the fuck you want.

this repository contains some parts that I did not create, which are licensed accordingly.

```license
DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE, Version 2

Copyright (C) 2025 aster-void

Everyone is permitted to copy and distribute verbatim or modified 
copies of this license document, and changing it is allowed as long 
as the name is changed. 

DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE 
TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION 

0. You just DO WHAT THE FUCK YOU WANT TO.
```
