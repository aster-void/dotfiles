# Ghostty can't find OpenGL on Fedora (SELinux + Nix)

## Symptom

Ghostty (installed via Nix Home Manager) fails to find OpenGL drivers on Fedora 43.

## Cause

Two issues combined:

1. `/run/opengl-driver` didn't exist — Nix-built apps look here for GPU drivers
2. The systemd service (`non-nixos-gpu.service`) that creates this symlink couldn't be enabled: "Access denied"

Root cause of the access denial: `non-nixos-gpu-setup` creates `/etc/systemd/system/non-nixos-gpu.service` as a symlink into `/nix/store/...`. Nix store files start with `default_t` SELinux context, which systemd refuses to read.

## Fix

Run `restorecon` on the nix store service file before running `non-nixos-gpu-setup`:

```sh
sudo restorecon /nix/store/...-non-nixos-gpu/lib/systemd/system/non-nixos-gpu.service
sudo non-nixos-gpu-setup
```

This relabels the file to `systemd_unit_file_t` (matching the fcontext rule for `lib/systemd/system/`), so systemd can read it through the symlink. The label persists because nix store files are immutable — but every new store path (from `home-manager switch`) starts as `default_t` again, so `restorecon` is needed each time the path changes. `install.sh` handles this automatically.

## Upstream context

- home-manager#8438: same bug reported on Fedora, closed as fixed
- home-manager#8443: moved service file from `resources/` to `lib/systemd/system/` so it matches SELinux fcontext rules
- The fix only works after `restorecon` — newly created nix store files always start as `default_t`

## What didn't work

- `cp --remove-destination` to copy the service file as a real file: works but unnecessary — `restorecon` on the store path is simpler and lets `non-nixos-gpu-setup` run unmodified
- Running `non-nixos-gpu-setup` without `restorecon`: "Access denied" from SELinux

## Scripts updated

`scripts/install.sh` and `scripts/install_system.sh` now run `restorecon` on the store service file before calling `non-nixos-gpu-setup`.
