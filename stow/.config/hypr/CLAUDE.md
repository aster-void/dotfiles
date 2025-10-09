# Hyprland Configuration

## Structure

- `hyprland.conf` - Main config
- `hyprland/` - Modular configs (bind, windowrules, exec, tearing, hardware-dep, plugins)

## Design Philosophy

**Minimal visual noise**: No gaps, borders, or rounding by default. Clean, distraction-free windows that maximize screen space.

**Selective enhancement**: Apply blur and rounding only to specific overlay windows (eww, waybar) via window rules to create visual hierarchy without cluttering the workspace.

**Auto-reload**: Config changes apply on save. No manual reload needed.

## Key Patterns

### Bind Flags

- **`bindn`**: Non-consuming. Passes key to active window AND triggers dispatcher.
  - Use for overlay controls that shouldn't interfere with apps (e.g., Escape closing power-menu while still working in fuzzel)
- **`bind`**: Consumes key event
- **`bindr`**: Triggers on release

### Blur Philosophy

`ignore_opacity = false` ensures blur respects window opacity, creating consistent visual depth. Blur is applied selectively via layer rules to UI overlays, not content windows.

### Per-Window Rounding

When applying rounding via `windowrulev2`, match CSS border-radius exactly to prevent rendering artifacts.
