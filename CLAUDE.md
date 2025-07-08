# CLAUDE.md - Project Knowledge Base

## Waybar CSS Styling Limitations

### Unsupported CSS Properties in Waybar
- `transform` - Cannot use scale(), translateY(), rotate(), etc.
- `backdrop-filter` - Blur effects not supported
- `position` - Cannot use absolute, relative positioning
- `height` - Cannot set explicit height
- `line-height` - Not supported for height control
- `-webkit-*` prefixes - Not supported

### Waybar-Compatible Styling Approaches

#### Height Control
- Use `margin` to control apparent height (e.g., `margin: 12px 8px`)
- Use `padding` for internal spacing (e.g., `padding: 0px 8px`)
- Use `font-size` to influence button height
- Use `min-width` and `min-height` for minimum dimensions

#### Animation & Effects
- Use `animation` property with keyframes
- Supported animations: `pulse`, `glow`, `blink`, `rainbow`, `float`
- Use `box-shadow` for glow effects and depth
- Use `opacity` changes for pulse effects
- Use `margin-top` changes for floating effects

#### Visual Effects
- Use `linear-gradient()` for backgrounds
- Use `alpha()` function for transparency
- Use `box-shadow` for depth and glow
- Use `border-radius` for rounded corners
- Use `text-shadow` for text effects

### Successful Waybar Styling Patterns

#### Button Styling
```css
#custom-power,
#custom-launcher {
  border-radius: 15px;
  margin: 12px 8px;  /* Vertical margin controls apparent height */
  font-size: 14px;
  font-weight: 700;
  padding: 0px 8px;  /* No vertical padding */
  min-width: 20px;
  background: linear-gradient(135deg, 
    alpha(@surface0, 0.9) 0%, 
    alpha(@surface1, 0.95) 50%, 
    alpha(@base, 0.9) 100%);
  box-shadow: 0 6px 20px rgba(0, 0, 0, 0.3),
              inset 0 1px 0 rgba(255, 255, 255, 0.15);
  border: 1px solid alpha(@overlay0, 0.4);
}
```

#### Hover Effects
```css
#element:hover {
  margin-top: -2px;  /* Simulates translateY transform */
  font-size: 14px;   /* Simulates scale transform */
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.4);
}
```

#### Animations
```css
@keyframes pulse {
  0% { opacity: 1; }
  50% { opacity: 0.8; }
  100% { opacity: 1; }
}

@keyframes float {
  0% { margin-top: 0px; }
  50% { margin-top: -2px; }
  100% { margin-top: 0px; }
}
```

## Color Scheme
Using Catppuccin Macchiato palette imported from `machiatto.css` with colors like:
- `@mauve`, `@lavender`, `@sky`, `@blue`, `@sapphire`
- `@teal`, `@green`, `@yellow`, `@peach`, `@red`
- `@surface0`, `@surface1`, `@surface2`, `@base`, `@mantle`, `@crust`

## Configuration Files
- Main config: `/home/aster/.dotfiles/.config/waybar/config.jsonc`
- Styles: `/home/aster/.dotfiles/.config/waybar/style.css`
- Color palette: `/home/aster/.dotfiles/.config/waybar/machiatto.css`

## Working Features
- Gradient backgrounds with transparency
- Smooth hover effects using margin and font-size changes
- Animated modules (pulse, glow, blink, rainbow, float)
- Grouped modules with connected borders
- Custom launcher and power buttons with square-like proportions
- Beautiful box shadows and inset highlights
- Player controls with music title display
- Unified hover effects based on clickability
- Compact design with different sizing for clickable vs non-clickable elements

## New Discoveries (2025-07-09)

### Waybar Configuration Tips
- **Height Control**: Waybar's `height` property in config.jsonc affects overall bar height
- **Margin Effects**: Larger vertical margins can make elements appear smaller/more compact
- **Clickability-Based Design**: Elements should be sized based on their function:
  - Clickable elements (buttons, controls): Larger padding/margins for better UX
  - Non-clickable elements (info displays): Smaller padding/margins for compactness

### CSS Limitations and Solutions
- **Font-size Changes**: Changing `font-size` in hover effects can cause layout shifts
  - Solution: Keep consistent font-size or use other visual effects
- **Hover Positioning**: Use consistent margins in hover states to prevent element shifting
- **Grouped Elements**: Each element in a group needs individual hover styling to maintain borders

### Player Control Integration
- **Music Title Display**: Use `playerctl metadata --format '{{ title }}'` for current track
- **Text Length Limiting**: Use `head -c 25` and `max-length` for overflow control
- **Click Behavior**: Music title should be display-only (no click handler)

### Design Patterns
- **Three-Tier Sizing**:
  1. Large: Clickable action buttons (power, launcher)
  2. Medium: Clickable controls (network, audio, player buttons)
  3. Small: Info displays (CPU, memory, time, music title)
- **Hover Effect Categories**:
  - Passive: Subtle effects for info displays
  - Interactive: Medium effects for controls
  - Action: Prominent effects for main buttons
- **Compact Design**: Use minimal padding (1-2px) and larger margins (6px) for non-clickable elements

### Color Scheme Optimizations
- **System Monitoring**: Unified blue color (@blue) for all resource indicators
- **Music Display**: Sky blue (@sky) with transparency for non-intrusive display
- **Button Consistency**: Maintain original color schemes while adjusting hover effects