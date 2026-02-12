# AGENTS.md

Note: CLAUDE.md is symlinked to this file.

## Overview

NixOS + Home Manager configuration. NixOS and home-manager are independent top-level directories.

## Directory Structure

- `nixos/hosts/{hostname}/` - NixOS host-specific config (default.nix, services/)
- `nixos/modules/` - NixOS system modules (base/, desktop/, profile-dev/, profile-server/)
- `nixos/secrets/` - agenix encrypted secrets
- `home-manager/hosts/{hostname}/` - home-manager per-host user config ({username}.nix)
- `home-manager/modules/` - home-manager modules (base/, desktop/, profile-dev/)
- `packages/` - Custom packages
- `config/` - Static config files (JSON, etc.)
- `dotter/` - Dotter-managed dotfiles

## Rules

**File Placement**: Shared across hosts → `{nixos,home-manager}/modules/`, host-specific → `{nixos,home-manager}/hosts/{hostname}/`

**Module Structure**
(`{nixos,home-manager}/modules/{module}/`):

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
scope: `flake` / `nixos/hosts/{hostname}` / `nixos/modules/{module}` / `home-manager/hosts/{hostname}` / `home-manager/modules/{module}` / `packages` / `treewide` / `meta`

**Rules**:
- Don't commit until explicitly told to
- Don't amend or edit existing commits
- Don't force push

## Scripts

```sh
./scripts/nixos-build.sh [hostname?] [--dry]  # NixOS build check
```

**Note**: This script never applies the config to the host. Without `--dry`, it builds only. With `--dry`, it evaluates only (no build).

**When to run build**: Only run when config structure changes (new modules, imports, options). Skip for simple changes like adding packages or modifying program settings.

## Tools

```sh
nix-search <query>  # Package search (nix-search-cli)
```

## Troubleshooting Logs

Location: `.claude/troubleshooting-logs/`

**Before troubleshooting**: Search existing logs for similar issues
```sh
grep -ri "<keyword>" .claude/troubleshooting-logs/
```

**After troubleshooting**: Create a log file documenting the issue and findings
```sh
# Format: {date}-{short-description}.md
# Example: 2025-01-13-hyprland-cursor-missing.md
```

## Tips

- **Don't modify NixOS system/"global" config directly**: Don't edit `~/.config/` or `~/.claude.json` directly. Edit the corresponding file in this repo. Search by program name to find it.
- **claude.md** = `home-manager/modules/profile-dev/programs/claude-code/claude.md` (source for global CLAUDE.md)
- Assume filename = what the file defines. Don't read files unnecessarily to save context.
- **Finding config for X**: `grep -r "filename"` (e.g., `grep -r zellij` to find zellij config)
- **Simple changes**: Don't over-research. Read the file, make the change, done.
- **git**: No `-C` flag needed. Working directory is repo root.
