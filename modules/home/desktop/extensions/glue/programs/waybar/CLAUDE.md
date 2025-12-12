# Waybar Guide

## Forbidden CSS Properties

**These cause errors:**

- `@keyframes` - keyframe animations unsupported
- `transform` - scale(), translateY(), rotate(), etc.
- `backdrop-filter` - blur effects unsupported
- `position` - absolute, relative unsupported
- `overflow` - hidden, scroll, etc.
- `height`, `max-height`, `min-height` - height constraints
- `line-height` - height control unsupported
- `white-space`, `text-overflow` - text control
- `-webkit-*` - prefixes unsupported
- `!important` - unsupported

## Waybar-Compatible Alternatives

### Height Control
- **`margin`** - visual height adjustment (`margin: 12px 8px`)
- **`padding`** - internal spacing (`padding: 0px 8px`)
- **`font-size`** - affects element height
- **`min-width`** - only width controllable

### Text Control
- Set `max-length: 50` in **config.jsonc**
- CSS text control not possible

### Safe Animations
- **`opacity`** - transparency changes
- **`box-shadow`** - shadow/glow effects
- **`background`** - color/gradient
- **`border`** - border changes

## Common Problems and Solutions

### Wrong
```css
#element {
  max-height: 16px;      /* Error! */
  overflow: hidden;      /* Error! */
  transform: scale(1.1); /* Error! */
}
```

### Correct
```css
#element {
  margin: 8px;           /* height adjustment */
  padding: 4px 8px;      /* internal spacing */
  box-shadow: 0 0 10px;  /* visual effect */
}
```

## Important Rules

2. **margin doesn't work on group elements** - use `spacing` in config.jsonc
3. **Animations don't change layout** - visual effects only
4. **Implement incrementally and test** - verify after each change

## Config Files

- **Main config**: `config.jsonc`
- **Styles**: `style.css`
- **Color palette**: `macchiato.css` (Catppuccin)

## Debugging Tips

- Check error logs carefully
- Use bright colors to verify selector behavior
- Understand config.jsonc vs CSS responsibilities
- Remove test code after completion

## Coding Rules

- Keep code absolutely minimal

## System Info

- waybar is managed by systemd user service
- File changes auto-reload, no explicit reload needed

```sh
# Check waybar logs
journalctl --user -u waybar --since '1 minute ago' --no-pager
```

## Design Language

- Visual consistency is top priority
- Aim for pixel perfect
- No size-change animations (not aesthetic)
- Mimic Apple's Liquid Glass
