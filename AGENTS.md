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

# Bluebell deployment flow
# 1. commit & push
# 2. ssh claude@bluebell.local "comin fetch"
# 3. ssh claude@bluebell.local "journalctl -u comin.service --no-pager -n 15"  # verify deploy
# 4. ssh claude@bluebell.local "systemctl status <service>"                    # verify service

# Utility Tools
nix-search package # Package search (nix-search-cli)
nix-search --program myprogram # search by program name instead of package name
flatpak search <keyword> # Flatpak app search (app ID for packages-desktop.nix)
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

### Before troubleshooting

- Before Troubleshooting: Search existing logs with `grep -ri "<keyword>" .claude/troubleshooting-logs/`

### After troubleshooting (whether it completed or failed)

match (the bug is a new one)
case new issue: Create `{date}-{short-description}.md` documenting findings
case existing issue re-occuring: Append to previous issue, add additional details and correct previous information as append-only with new date at top

Log format:

- **ROOT CAUSE** - brief context of the problem
- **TRIALS** - what was tried, with "What" and "Why failed/worked" for each
- **TAKEAWAY** - reusable knowledge summarized
- Focus on reusable knowledge (what failed/worked and why), not machine state (my config is currently this).

When you encounter unexpected behaviors, search for relevant debug logs, as they may help you debug the new issue.

## Debugging Mindset

When encountering an issue, always search the web for it first. Countless people exist in the world, and it's extremely rare that you're the only one experiencing a given problem. Existing solutions are almost always out there.
