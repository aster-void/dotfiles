# Flatpak apps cannot open links

## Symptom

Discord (Flatpak) clicking links does nothing.

## Cause

`xdg.portal.config.common.default = "*"` only loads portals matching `XDG_CURRENT_DESKTOP`.

GTK portal has `UseIn=gnome`, so it's not loaded under Hyprland. The GTK portal provides `OpenURI` (link opening) - without it, links fail silently.

## Fix

```nix
# modules/home/desktop/programs/hyprland/default.nix
xdg.portal.config.common.default = ["hyprland" "gtk"];
```

Explicit list overrides `UseIn=` filtering, ensuring both portals load.

## Quick verification

```sh
# Check if GTK portal is running
systemctl --user status xdg-desktop-portal-gtk

# Check if OpenURI interface exists
dbus-send --session --print-reply \
  --dest=org.freedesktop.portal.Desktop \
  /org/freedesktop/portal/desktop \
  org.freedesktop.DBus.Introspectable.Introspect | grep -i openuri
```

## Temporary fix (until rebuild)

```sh
systemctl --user restart xdg-desktop-portal xdg-desktop-portal-gtk
```

## Recurrence

- 2026-02-27: Same symptom reappeared. Portal restart fixed it again. Root config is correct, portal just gets into a bad state sometimes (possibly after sleep/resume or session restart).
