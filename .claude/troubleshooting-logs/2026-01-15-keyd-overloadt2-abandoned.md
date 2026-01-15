# keyd home row mods: overloadt2 vs overload vs lettermod

## Problem History

### overload + overload_tap_timeout
- Modifier is instant
- But subsequent keys during fast typing are eaten (interpreted as modified)

### overloadt2
- Fast typing works
- But modifier has delay (must hold for timeout before it activates)

## Solution: lettermod

`lettermod(layer, key, idle_timeout, hold_timeout)` expands to:
```
overloadi(key, overloadt2(layer, key, hold_timeout), idle_timeout)
```

### How it works
- `idle_timeout` (150ms): if a key was pressed within this time, output key immediately (fast typing mode)
- `hold_timeout` (200ms): otherwise, use overloadt2 behavior

### Behavior
- Fast typing: keys output immediately (overloadi detects typing streak)
- After pause + hold: modifier activates (overloadt2 kicks in)

## Config
```nix
f = "lettermod(shift, f, 150, 200)";
```

## Sources
- https://github.com/rvaiya/keyd/blob/master/docs/keyd.scdoc
- https://precondition.github.io/home-row-mods
