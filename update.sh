#!/usr/bin/env bash
(cd ~/.dotfiles && stow .) &\
home-manager switch
