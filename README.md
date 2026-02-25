# dotfiles

My system configuration — NixOS, Home Manager, and Dotter, all in one repo.

## Structure

- **`nixos/`** — NixOS system configuration (flake, hosts, modules, secrets)
- **`home-manager/`** — packages, session variables, services (Nix flake)
- **`dotter/`** — program configs deployed to `~/.config/`
- **`etc/`** — system-level config files (Fedora, deployed manually)
- **`scripts/`** — install/upgrade scripts for non-NixOS setups

## NixOS

Managed via [comin](https://github.com/nlewo/comin) — push to `main` and it auto-deploys.

```sh
./nixos/scripts/nixos-build.sh          # build check (never applies)
./nixos/scripts/nixos-build.sh --dry    # eval only
```

## Non-NixOS Setup

```sh
curl -fsSL https://raw.githubusercontent.com/aster-void/dotfiles/main/bootstrap.sh | bash
```

### Scripts

- **`install.sh`** — Apply config changes (Home Manager + Dotter)
- **`install_system.sh`** — Desktop setup: dnf packages, `/etc/`, shell, GPU, WARP (Fedora, sudo)
- **`upgrade.sh`** — Full system upgrade (dnf, flake, flatpak, firmware)
