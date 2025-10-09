#!/usr/bin/env bash

# Stop graphical-session.target before exiting Hyprland
# This ensures clean shutdown of all session-bound services like Waybar, fcitx5, etc.
systemctl --user stop graphical-session.target

# Exit Hyprland
hyprctl dispatch exit