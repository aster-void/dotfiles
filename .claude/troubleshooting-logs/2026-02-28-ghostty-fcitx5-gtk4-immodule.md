# Ghostty (Nix GTK4) can't find fcitx5 IM module (2026-02-28)

## Symptom
- fcitx5 works in Zen Browser but not in Ghostty
- Meta+Space does nothing in Ghostty
- Ghostty does not register an InputContext with fcitx5

## Root Cause
Ghostty (installed via Nix) uses Nix's GTK4, which doesn't know where to find the fcitx5 GTK4 IM module (`libim-fcitx5.so`). GTK4 logs:

```
No IM module matching GTK_IM_MODULE=fcitx found
```

The module exists at `~/.nix-profile/lib/gtk-4.0/4.0.0/immodules/libim-fcitx5.so` (from `fcitx5-gtk` in Home Manager), but GTK4 doesn't search that path by default.

Previously this wasn't an issue because KWin's input-method-v2 protocol handled IM for all Wayland apps (bypassing GTK IM modules). When that broke (see wayland-connection-failure log), the missing GTK_PATH was exposed.

## Diagnosis
- `qdbus org.fcitx.Fcitx5 /controller org.fcitx.Fcitx.Controller1.DebugInfo` showed no Ghostty InputContext
- Launching Ghostty from terminal showed `No IM module matching GTK_IM_MODULE=fcitx found`
- `GTK_PATH=~/.nix-profile/lib/gtk-4.0 ghostty` fixed it

## Fix
Added `GTK_PATH` to `dotter/config/environment.d/20-fcitx5.conf`:

```
GTK_PATH=${HOME}/.nix-profile/lib/gtk-4.0
```

This tells all GTK4 apps to search the Nix profile for IM modules.

For immediate effect without relogin:
```sh
systemctl --user set-environment GTK_PATH=/home/aster/.nix-profile/lib/gtk-4.0
```

## Environment
- Ghostty 1.2.3 (Nix), GTK4 4.20.3
- fcitx5-gtk 5.1.5 (Nix/Home Manager)
- KDE Plasma 6.5.5 (Wayland), Nobara 43
