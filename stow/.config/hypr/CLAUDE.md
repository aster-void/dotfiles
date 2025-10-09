# Hyprland Configuration

## Structure

- `hyprland.conf` - Main configuration file
- `hyprland/` - Modular configuration directory
  - `bind.conf` - Keybindings
  - `windowrules.conf` - Window and layer rules
  - `exec.conf` - Autostart programs
  - `tearing.conf` - Tearing configuration
  - `hardware-dep.conf` - Hardware-specific settings
  - `plugins.conf` - Plugin configurations

## Important Patterns

### Bind Flags

When binding keys, use appropriate flags for the behavior you need:

- **`bindn`** (non-consuming): Key events are passed to active window AND trigger the dispatcher
  - Use case: Close overlay menus while allowing the key to work in other apps
  - Example: `bindn = , escape, exec, eww close power-menu`
  - This allows Escape to close power-menu AND still work in fuzzel/other apps

- **`bind`** (default): Consumes the key event, only triggers the dispatcher
- **`bindr`** (on release): Triggers when key is released

### Layer Rules

Layer rules apply to GTK Layer Shell windows (waybar, eww, etc.):

```conf
layerrule = blur, waybar
layerrule = blur, eww
```

### Window Rules

Window rules use `windowrulev2` for more precise matching:

```conf
windowrulev2 = opacity 0.85, class: kitty
windowrulev2 = noblur, class: kitty, floating: 1, focus: 0
```

## Blur Configuration

Current blur settings:
- Size: 8
- Passes: 3
- `ignore_opacity = false` (blur respects opacity)
- `new_optimizations = true`
- `xray = false`

## Decoration

- `rounding = 16` - Must match CSS border-radius for proper rendering
- If CSS uses `border-radius: 16px`, Hyprland rounding must be 16

## Reloading

**IMPORTANT: Hyprland automatically reloads configuration files when they are saved.**

You do NOT need to manually run `hyprctl reload` when editing configuration files. The changes will be applied immediately upon file save.

Manual reload is only needed in rare cases:
```sh
hyprctl reload  # Manual reload (rarely needed)
```
