#!/usr/bin/env bash

dir=$(cd `dirname -- $0`; pwd)
cd $dir

./home-manager-init.sh
./stow-init.sh

./.config/hypr/init.sh
./.config/alacritty/init.sh

./update.sh
