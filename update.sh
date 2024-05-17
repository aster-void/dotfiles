#!/usr/bin/env bash

echo "updating home manager..."
nix-channel --update 2>&1 > /dev/null
home-manager switch 2>&1 > /dev/null
echo "updating home manager done"
