# AGENTS.md

Note: CLAUDE.md is symlinked to this file.

## Tools

```sh
# Nix
nix-search <query>                                   # Package search (nix-search-cli)

# Installation & Utility commands
./scripts/install.sh # install user-wide config [always run this after changes!]
./scripts/install_system.sh # install system-wide config
./scripts/upgrade.sh # update system and this config

# NixOS
./nixos/scripts/nixos-build.sh [hostname?] [--dry]   # Build check (never applies config; --dry = eval only)
comin fetch                                          # Trigger comin to fetch and deploy latest commit (no sudo)
journalctl -u comin.service --no-pager -n 30         # Check comin deploy logs (no sudo)
```

When to run build: Only when config structure changes (new modules, imports, options). Skip for simple changes like adding packages or modifying program settings.

## Troubleshooting Logs

Location: `.claude/troubleshooting-logs/`

- Before Troubleshooting: Search existing logs with `grep -ri "<keyword>" .claude/troubleshooting-logs/`
- After Troubleshooting: Create `{date}-{short-description}.md` documenting findings

## Tips

- Don't modify system config directly: Don't edit `~/.config/` or `~/.claude.json`. Edit the corresponding file in this repo.
