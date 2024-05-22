#!/usr/bin/env bash

dir="~/.dotfiles"

${dir}/.home-manager.init.sh
${dir}/.stow.init.sh $dir

${dir}/.config/hypr/.init.sh $dir
${dir}/.config/alacritty/.init.sh

rustup component add rust-analyzer

${dir}/update.sh
