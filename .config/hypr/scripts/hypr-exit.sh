#!/usr/bin/env bash

# Stop hyprland-session.target before exiting Hyprland
# This ensures clean shutdown of all session-bound services like Waybar
systemctl --user stop hyprland-session.target

# Exit Hyprland
hyprctl dispatch exit