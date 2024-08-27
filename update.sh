#!/usr/bin/env bash

cd `dirname -- $0`

echo "updating home manager..."
nix-channel --update 2>&1 > /dev/null
home-manager switch 2>&1 > /dev/null
echo "updating home manager done"
