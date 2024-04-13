#!/usr/bin/env bash

cp ~/.config/kitty/kitty-themes/themes/$1.conf ~/.config/kitty/theme.conf
echo "changed kitty theme to theme: $1"
