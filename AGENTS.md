# AGENTS.md

Note: CLAUDE.md is symlinked to this file.

## Tools

```sh
# cross-domain scripts
./scripts/upgrade.sh # update system and this config

# dotter/ and home-manager/
./scripts/install.sh # install user-wide config [always run this after changes!]

# etc/ (for imperative distros)
./scripts/install_system.sh # install system-wide config

# nixos/
./nixos/scripts/nixos-build.sh [hostname?] [--dry]   # Build check (never applies config; --dry = eval only)
comin fetch                                          # Trigger comin to fetch and deploy latest commit (no sudo)
journalctl -u comin.service --no-pager -n 30         # Check comin deploy logs (no sudo)

# Utility Tools
nix-search package # Package search (nix-search-cli)
nix-search --program myprogram # search by program name instead of package name
```

When to run build: Only when config structure changes (new modules, imports, options). Skip for simple changes like adding packages or modifying program settings.

## Quick Look

- CLI packages: `home-manager/modules/packages.nix`
- Desktop/GUI packages + Flatpak apps: `home-manager/modules/packages-desktop.nix`
- Dotter file mappings: `dotter/global.toml`
- Dotter dotfiles source: `dotter/config/`, `dotter/ssh/`, `dotter/claude/`, `dotter/local/`
- User scripts (on PATH): `dotter/local/bin/`
- Home Manager modules: `home-manager/flake.nix` (imports all modules)
- NixOS system config (for servers only): `nixos/`

## Troubleshooting Logs

Location: `.claude/troubleshooting-logs/`

- Before Troubleshooting: Search existing logs with `grep -ri "<keyword>" .claude/troubleshooting-logs/`
- After Troubleshooting: Create `{date}-{short-description}.md` documenting findings

## Tips

- Don't modify system config directly: Don't edit `~/.config/` or `~/.claude.json`. Edit the corresponding file in this repo.
