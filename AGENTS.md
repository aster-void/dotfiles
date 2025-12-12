# AGENTS.md

Note: CLAUDE.md is symlinked to this file.

## Overview

NixOS-based unified system configuration (server + desktop). Managed with Blueprint framework.

## Directory Structure

- `hosts/{hostname}/` - Host-specific config (configuration.nix, services/, users/)
- `modules/nixos/` - NixOS system modules (base/, desktop/, profile-dev/)
- `modules/home/` - home-manager modules (desktop/, profile-dev/)
- `packages/` - Custom packages
- `config/` - Static config files (JSON, etc.)
- `secrets/` - agenix encrypted secrets

## Rules

**File Placement**: Shared across hosts → `modules/`, host-specific → `hosts/{hostname}/`

**Module Structure**
(`modules/{home|nixos}/{module}/`):
- `default.nix` - imports submodules
- `options.nix` - module `options`
- `programs/` - program configs
- `services/` - external-facing services
- `system/` - internal services, hardware
- `extensions/` - enabled via `my.{module}.{extension}.enable`
- `packages.nix` - package installation only
- `xdg.nix` `env.nix` ... - as named: not system, service, or program specific

**flake.lib.collectFiles**
Function to auto-collect files in a directory.
- Directory with `default.nix` → returns only `default.nix` (no recursion)
- Directory without `default.nix` → recursively collects all files

Example:
```nix
imports = flake.lib.collectFiles ./programs ++ flake.lib.collectFiles ./services;
```

**When default.nix is needed:**
1. **Selection modules** - display-managers, window-managers, etc. where one option is chosen from multiple
2. **Main config file** - helix/default.nix, hyprland/default.nix, etc. for main config + subfile imports
3. **Data file exclusion** - shells/default.nix exists to exclude common-aliases.nix (data, not a module)

## Commits

Format: `{scope}: {description}`
scope: `flake` / `hosts/{hostname}` / `modules/{module}` / `packages` / `treewide` / `meta`

## Scripts

```sh
./scripts/nixos-build.sh [hostname?] [--show-error]  # NixOS build check
./scripts/home-build.sh [--show-error]               # home-manager build check
```

## Tools

```sh
nix-search <query> # Package search
```

## Tips

- **Don't modify NixOS system/"global" config directly**: Don't edit `~/.config/` or `~/.claude.json` directly. Edit the corresponding file in this repo. Search by program name to find it.
- **claude.md** = `modules/home/profile-dev/programs/claude-code/claude.md` (source for global CLAUDE.md)
- Assume filename = what the file defines. Don't read files unnecessarily to save context.
- **Finding config for X**: `grep -r "filename"` (e.g., `grep -r zellij` to find zellij config)
- **Simple changes**: Don't over-research. Read the file, make the change, done.
