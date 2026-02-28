# fcitx5 fails to connect to Wayland on boot (2026-02-28)

## Symptom
- fcitx5 running but not activating (fcitx5-remote returns 0)
- Meta+Space keybind not working
- DebugInfo shows 0 InputContexts

## Root Cause
Home Manager's `i18n.inputMethod` starts fcitx5 as a systemd service with `After=graphical-session.target`, but the Wayland socket (`$XDG_RUNTIME_DIR/wayland-0`) isn't ready yet at that point. fcitx5 logs `Failed to open wayland connection` and runs without Wayland connectivity.

## Diagnosis
- `journalctl --user -u fcitx5-daemon.service` showed `Failed to open wayland connection`
- `qdbus org.fcitx.Fcitx5 /controller org.fcitx.Fcitx.Controller1.DebugInfo` showed 0 InputContexts
- Restarting fcitx5 after login resolved the issue (Wayland socket existed by then)

## Fix
Added systemd service override in `home-manager/modules/i18n.nix`:

```nix
systemd.user.services.fcitx5-daemon.Service = {
  ExecStartPre = "${pkgs.bash}/bin/bash -c 'for i in $(seq 1 50); do [ -S \"$XDG_RUNTIME_DIR/wayland-0\" ] && exit 0; sleep 0.1; done; exit 1'";
  Restart = "on-failure";
  RestartSec = 1;
};
```

Waits up to 5 seconds for the Wayland socket to appear before starting fcitx5. `Restart=on-failure` provides additional resilience.

## Environment
- KDE Plasma 6.5.5 (Wayland), Nobara 43
- fcitx5 5.1.16 (Nix/Home Manager)
- hazkey input method
