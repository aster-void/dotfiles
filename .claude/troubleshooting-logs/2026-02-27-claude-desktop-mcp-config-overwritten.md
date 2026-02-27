# Claude Desktop: mcpServers stripped from config on tab switch

Date: 2026-02-27
Keywords: claude desktop, GUI, flatpak, electron, config overwrite, MCP, stale process

## Symptom

`mcpServers` block in `~/.config/Claude/claude_desktop_config.json` gets silently removed.
`preferences` block is preserved. Happens on tab switch, not just on startup.

## Environment

- Fedora 43 (claude-desktop-debian DNF package)
- Config managed via dotter symlink

## Root cause

Stale Claude Desktop (Electron) processes running in background.
These processes overwrite the config file, dropping the `mcpServers` block.

## Additional issue: Electron PATH

Electron doesn't inherit Nix shell PATH, so `bunx`/`uvx` must use absolute paths.
See: https://github.com/aaddrick/claude-desktop-debian/issues/216

## Fix

1. Kill all stale Claude Desktop / Electron processes before editing config
2. Use full paths for MCP server commands (e.g. `/home/aster/.nix-profile/bin/bunx`)

## Related

- https://github.com/aaddrick/claude-desktop-debian/issues/216
- https://github.com/aaddrick/claude-desktop-debian/issues/238
