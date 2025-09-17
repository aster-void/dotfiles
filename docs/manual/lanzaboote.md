# Lanzaboote (Secure Boot on NixOS)

## Overview

- Integrates `lanzaboote` via flake input and module flag `my.boot.enableLanzaboote`.
- Signs systemd‑boot and the kernel with your own Secure Boot keys using `sbctl`.
- Keys are stored in `/var/lib/sbctl` (see `boot.lanzaboote.pkiBundle`).

## Prerequisites

- UEFI system with Secure Boot support (not legacy/CSM). Check: `ls /sys/firmware/efi/vars` exists.
- Temporarily disable Secure Boot in firmware until keys are enrolled.
- EFI System Partition mounted at `/boot`.

## Step 1 — Enable the module in your host

Add the lanzaboote flag to your host module:

```
# nixos/hosts/<host>/default.nix
my.boot.enableLanzaboote = true;
```

## Step 2 — Build your system (don’t switch yet)

Build to ensure configuration evaluates with lanzaboote enabled:

```
nixos-rebuild build --flake .#<host>
```

## Step 3 — Enter Setup Mode (clear vendor keys)

Put firmware into Secure Boot “Setup Mode” before enrolling your own keys.

WARNING: If you dual‑boot Windows with BitLocker/Device encryption, suspend it and back up the recovery key before clearing keys, or Windows may require the recovery key on next boot.

1. Reboot into firmware setup and open Secure Boot settings.
2. Disable Secure Boot (if enabled).
3. Enter secure‑boot key management and CLEAR/DELETE all keys (PK/KEK/db/dbx). On some vendors select “Custom Mode” → “Delete All Keys”.
   - Do NOT “Restore/Install factory keys”; that keeps you in User Mode.
4. Enable Secure Boot back.
5. Save and boot back to NixOS.
6. Verify: `sbctl status` should report “Setup Mode: enabled”.

## Step 4 — Create your Secure Boot keys

Generate keys into the configured bundle path:

```
sudo sbctl create-keys
```

## Step 5 — Enroll keys into firmware

Enroll your Platform Key (PK), Key‑Exchange Key (KEK), and signature databases:
Optional: also enroll Microsoft keys (useful for Windows/third‑party drivers).

```
sudo sbctl enroll-keys [--microsoft]
```

## Step 6 — Switch and sign

Apply your system so lanzaboote signs the boot artifacts:

```
sudo nixos-rebuild switch --flake .#<host>
```

## Step 7 — Verify signatures

After a reboot, check that components are signed and Setup/User Mode is as expected and Secure Boot is enabled:

```
sudo sbctl status
sudo sbctl verify

# if sbctl verify clutters,
sudo -s
sbctl verify 2>/dev/null | rg Linux
# if you see one of these, you're good
# ✓ /boot/EFI/Linux/nixos-generation-6-xq4pxr5qhd2raehkb6yrr6lmb37c3kva6h3xlns2skypvfokhqxq.efi is signed
# ✓ /boot/EFI/Linux/nixos-generation-7-vvzwt6r56wweolcuid22t2fbmc5safpds6eis4lg3btjw6wmce7q.efi is signed
# ✓ /boot/EFI/Linux/nixos-generation-8-sc7zc4ponkzydo3bbzg5kb5hhxc55d5k5dolcu7xplctpkm4vxpa.efi is signed
```

## Dual‑boot with Windows (BitLocker)

- BitLocker (aka “Device encryption” on Windows Home) may be enabled by default on OEM laptops.

Windows/BitLocker checklist by step

### Before Step 3 (clear vendor keys):

Suspend Bitlocker.

```ps
# (optional) backup recovery key:
manage-bde -protectors -get C:

Suspend-Bitlocker -MountPoint "C:" -RebootCount 1
```

### At Step 5 (enroll keys):

- also enroll Microsoft keys: `sudo sbctl enroll-keys --microsoft`.

### Step 8 (re‑enable Secure Boot):

After first successful boots, resume BitLocker:

```ps
Resume-Bitlocker -MountPoint "C:"
```

## Troubleshooting

- Boot fails with Secure Boot on: disable it again, boot NixOS, run `sbctl status` and re‑verify your keys, then re‑enroll.
- `efivars` errors: ensure UEFI mode, `boot.loader.efi.canTouchEfiVariables = true;`, and that `/boot` is your ESP.
- “Your system is not in Setup Mode!”: follow Step 3 to clear vendor keys first.
- Wrong key path: this repo uses `/var/lib/sbctl` via `boot.lanzaboote.pkiBundle`; keep `sbctl` operations consistent with that path.

## Secure Boot State Timeline

- Fresh enablement (coming from non‑SB GRUB or new install):

  - Firmware: Secure Boot = Disabled → Setup Mode (no keys).
  - NixOS: enable lanzaboote, build, create + enroll keys, switch.
  - Reboot to firmware: set Secure Boot = Enabled; boot.

- Updating an existing lanzaboote system:

  - Keep Secure Boot = Enabled.
  - `nixos-rebuild switch` will sign new boot artifacts.

- Recovery if boot fails with Secure Boot:
  - Temporarily disable Secure Boot to boot NixOS.
  - `sbctl status` / `sbctl verify --all`; re‑enroll keys if needed.
  - Re‑enable Secure Boot.

## References

- Lanzaboote quick start: https://github.com/nix-community/lanzaboote
- sbctl manual: https://github.com/Foxboron/sbctl
