# keyd: Physical Shift Key Delay

## Problem

Physical shift key required holding for a moment before it took effect. Some keys wouldn't capitalize properly when shift was pressed quickly.

## Cause

`lettermod(shift, f, ...)` uses keyd's built-in `shift` layer, which conflicts with the physical shift key's default behavior. Both the physical shift and home row mod shift were using the same layer, causing the physical shift to inherit the timing behavior of `lettermod`.

## Solution

Use a separate layer name (`hrmshift`) for home row mod shift keys:

```nix
f = "lettermod(hrmshift, f, 100, 200)";
j = "lettermod(hrmshift, j, 100, 200)";
# ...
"hrmshift:S" = {};  # Layer with Shift modifier
```

This keeps physical shift using the default `shift` layer (immediate response) while home row mods use the custom `hrmshift` layer with timing.

## Things That Didn't Work

- `leftshift = "shift"` - No effect, same as default
- `chord_timeout = 0` - Unrelated to the issue
- `disable_modifier_guard = 1` - Has side effects, not the right fix
