# AGENTS.md

## Repository Overview

This is a NixOS and Home Manager dotfiles repository. It manages system configurations across multiple hosts with both native NixOS and WSL variants.

## Development Commands

### Building and Testing

```sh
# Build NixOS system configuration (doesn't activate)
sudo nixos-rebuild build --flake .#<hostname>

# Build Home Manager configuration (doesn't activate)
home-manager build --flake .#aster@<hostname>

# Apply NixOS configuration
sudo nixos-rebuild switch --flake .#<hostname>

# Apply Home Manager configuration
home-manager switch --flake .#aster@<hostname>

# Available hosts: amberwood, bogster, carbon, dusk
# WSL variants: aster@amberwood-wsl, aster@carbon-wsl
```

### Code Quality Tools

```sh
# Format Nix files (auto-runs on pre-commit)
alejandra .

# Check for dead code (auto-runs on pre-commit)
deadnix --fail .

# Lint Nix code (currently disabled in lefthook.yml)
statix check .

# Install git hooks
lefthook install
```

### Development Environment

```sh
# Enter dev shell with all tools
nix develop

# The dev shell includes: alejandra, deadnix, statix, nil, lefthook, nwg-look, agenix
```

### Secrets Management

```sh
# Edit secrets (agenix)
# RULES environment variable is set to secrets/secrets.nix in dev shell
agenix -e <secret-name>
```

## Architecture

### Flake Structure

- **`flake.nix`**: Main entry point defining inputs, outputs, and dev shell
- **`meta.nix`**: User metadata (username, git config, SSH public keys, system architecture)
- **`nixos/`**: NixOS system configurations
- **`home-manager/`**: Home Manager user configurations
- **`my/`**: Custom packages and modules
- **`shared/`**: Shared utilities used by both NixOS and Home Manager
- **`secrets/`**: agenix encrypted secrets

### NixOS Structure (`nixos/`)

- **`configuration.nix`**: Root NixOS config importing core and profiles
- **`core/`**: Core system settings (bootloader, network, i18n, hardware, services, nix config)
- **`profiles/`**: Feature profiles (desktop, development, gaming, nixos-wsl)
  - Profiles are opt-in via `my.profiles.<name>.enable` options
- **`hosts/<hostname>/`**: Per-host configurations and hardware-configuration.nix

Each NixOS system is built via `mkSystemConfig` in `nixos/default.nix` which includes:
- agenix, comin, and lanzaboote NixOS modules
- Host-specific configuration from `hosts/<hostname>/`

### Home Manager Structure (`home-manager/`)

- **`profiles/`**: User profile combinations (base, desktop, dev, game, wsl)
- **`features/`**: Modular feature configurations (apps, gui, hm, i18n, secrets, shell, xdg)

Home Manager configs are built via `mkConfiguration` in `home-manager/default.nix` which composes profiles.

### Custom Repository (`my/`)

- `my/pkgs`: Custom package repository
- `my/homeManagerModules`: Custom Home-Manager modules

These are exposed via `my` in specialArgs.

### Shared Configuration (`shared/`)

Exposed via `shared` in specialArgs.

## Key Patterns

### SpecialArgs System

Both NixOS and Home Manager configs receive these specialArgs:
- `inputs`: Flake inputs
- `my`: Custom packages from `my/pkgs/`
- `meta`: User metadata from `meta.nix`
- `shared`: Shared utilities
- `system`: Target system architecture (x86_64-linux)
- `host`: (NixOS only) Current hostname

### Profile System

NixOS profiles use `my.profiles.<name>.enable` options defined in `nixos/profiles/default.nix`.

Home Manager profiles are composable directory imports defined in `home-manager/default.nix`.

## Important Notes

- Keep files short (10-50 lines ideal, max 100)
- Split large modules into `default.nix` + feature files
- always use flat architecture + facade pattern
  - top-level module imports all modules in the directory.
  - import ./something/default.nix; default.nix imports each module in something/*.
- for togglable nix options, use `options` and `config`. don't conditionally import.
- on migration, ALWAYS make sure functionality is fully migrated before deleting files.
- delete stale files after migration.
