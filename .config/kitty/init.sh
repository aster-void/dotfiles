#!/usr/bin/env bash

cd ~/.dotfiles/.config/kitty
ln -s ./kitty-themes/themes/Apprentice.conf ~/.config/kitty/theme.conf
cp hardware-dep.conf.sample hardware-dep.conf
