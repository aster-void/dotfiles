# CLAUDE.md - Project Knowledge Base

## 🚨 WAYBAR CSS RESTRICTIONS - READ CAREFULLY! 🚨

### ❌ ABSOLUTELY FORBIDDEN CSS Properties in Waybar
**These properties will cause errors and MUST NEVER be used:**
- `transform` - Cannot use scale(), translateY(), rotate(), etc.
- `backdrop-filter` - Blur effects not supported
- `position` - Cannot use absolute, relative positioning
- `height` - Cannot set explicit height
- `line-height` - Not supported for height control
- `max-height` - Height constraints not supported ⚠️ **CAUSES ERRORS**
- `min-height` - Height constraints not supported ⚠️ **CAUSES ERRORS**
- `overflow` - Cannot control content overflow ⚠️ **CAUSES ERRORS**
- `white-space` - Text wrapping control not supported ⚠️ **CAUSES ERRORS**
- `text-overflow` - Ellipsis and overflow text handling not supported ⚠️ **CAUSES ERRORS**
- `-webkit-*` prefixes - Not supported

### ✅ WAYBAR-COMPATIBLE Height & Size Control

#### Height Control (ONLY these methods work)
- **`margin`** - Use to control apparent height (e.g., `margin: 12px 8px`)
- **`padding`** - Use for internal spacing (e.g., `padding: 0px 8px`)
- **`font-size`** - Influences element height
- **`min-width`** - Controls minimum width only (NOT height)

#### Text Content Control
- **Use config file only**: Set `max-length: 50` in config.jsonc
- **Cannot use CSS**: No `text-overflow`, `white-space`, `overflow` support
- **Height expansion solution**: Use minimal `padding` and adjust `margin`

#### Animation & Effects (SAFE)
- **`animation`** property with keyframes
- **Supported animations**: `pulse`, `glow`, `blink`, `rainbow`
- **`box-shadow`** for glow effects and depth
- **`opacity`** changes for pulse effects
- **`linear-gradient()`** for backgrounds
- **`alpha()`** function for transparency
- **`border-radius`** for rounded corners
- **`text-shadow`** for text effects

## Configuration Files
- Main config: `/home/aster/.dotfiles/.config/waybar/config.jsonc`
- Styles: `/home/aster/.dotfiles/.config/waybar/style.css`
- Color palette: `/home/aster/.dotfiles/.config/waybar/machiatto.css`

## Color Scheme
Using Catppuccin Macchiato palette imported from `machiatto.css` with colors like:
- `@mauve`, `@lavender`, `@sky`, `@blue`, `@sapphire`
- `@teal`, `@green`, `@yellow`, `@peach`, `@red`
- `@surface0`, `@surface1`, `@surface2`, `@base`, `@mantle`, `@crust`

## Critical Discoveries (2025-07-09 Session)

### ⚠️ CRITICAL WAYBAR STYLING ERRORS TO AVOID

#### 🚨 FORBIDDEN Properties That Cause Errors
**These will break Waybar with error messages:**
- `max-height` ❌ **CAUSES: "max-height is not a valid property name"**
- `min-height` ❌ **CAUSES: "min-height is not a valid property name"**
- `overflow` ❌ **CAUSES: "overflow is not a valid property name"**
- `white-space` ❌ **CAUSES: "white-space is not a valid property name"**
- `text-overflow` ❌ **CAUSES: "text-overflow is not a valid property name"**

#### 🔧 How to Fix Height/Content Issues WITHOUT Forbidden Properties

**❌ WRONG - Using forbidden properties:**
```css
#hyprland-window {
  max-height: 16px;        /* ERROR! */
  overflow: hidden;        /* ERROR! */
  white-space: nowrap;     /* ERROR! */
  text-overflow: ellipsis; /* ERROR! */
}
```

**✅ CORRECT - Waybar-compatible approach:**
```css
#hyprland-window {
  margin: 8px 8px;         /* Controls apparent height */
  padding: 0px 14px;       /* Minimal internal spacing */
  min-width: 100px;        /* Width control only */
}
```

**✅ For text length control, use config.jsonc:**
```json
"hyprland/window": {
  "format": "{}",
  "max-length": 50          /* Text truncation in config, NOT CSS */
}
```

#### Problem: Generic Hover Rule Conflicts
- **Issue**: Generic `.action-hover:hover` rules conflict with individual button hover settings
- **Symptoms**: Buttons turn black/gray on hover instead of maintaining their colors
- **Solution**: Remove specific selectors from generic rules and create dedicated hover styles
```css
/* WRONG: Generic rule affecting all buttons */
.action-hover:hover,
#custom-power:hover,
#custom-launcher:hover { ... }

/* CORRECT: Individual rules for each button */
#custom-power:hover { color: @base; background: @red; }
#custom-launcher:hover { color: @base; background: @mauve; }
```

#### Problem: Font-size Changes Cause Layout Shifts
- **Issue**: Changing `font-size` in hover effects makes elements "jump" and shift layout
- **Symptoms**: Elements move/resize on hover, affecting neighboring elements
- **Solution**: ❌ Avoid `font-size` changes in hover states
```css
/* WRONG: Causes layout shifts */
#element:hover { font-size: 15px; }

/* CORRECT: Use only visual effects */
#element:hover { box-shadow: 0 0 20px @color; }
```

#### Problem: Animation Layout Impact
- **Issue**: Animations changing `margin-top`, `padding`, or positioning cause layout shifts
- **Symptoms**: Elements "bounce" or move other elements during animation
- **Solution**: ❌ Avoid animations that change layout properties
```css
/* DANGEROUS: Changes layout */
@keyframes float {
  0% { margin-top: 0px; }
  50% { margin-top: -2px; }
}

/* SAFE: Only visual changes */
@keyframes pulse {
  0% { opacity: 1; }
  50% { opacity: 0.8; }
}
```

### ✅ Effective Hover Effect Implementation

#### Multi-layer Glow Effects
```css
#element:hover {
  box-shadow: 0 8px 30px rgba(0, 0, 0, 0.5),      /* Deep shadow */
              0 0 30px alpha(@color, 0.9),         /* Inner glow */
              0 0 60px alpha(@color, 0.6),         /* Outer glow */
              inset 0 2px 0 rgba(255, 255, 255, 0.3),  /* Top highlight */
              inset 0 -2px 0 rgba(0, 0, 0, 0.2);   /* Bottom shadow */
}
```

#### Safe Animation Types
- ✅ **opacity**: Changes transparency (pulse effect)
- ✅ **box-shadow**: Changes glow/shadow effects
- ✅ **background**: Changes colors/gradients
- ✅ **border**: Changes border properties
- ❌ **margin/padding**: Affects layout
- ❌ **font-size**: Affects element size
- ❌ **transform**: Not supported in Waybar

### 📋 CSS Rule Management Best Practices

#### Rule Specificity Strategy
1. **Generic rules**: For common base styles only
2. **Individual rules**: For specific element behavior
3. **Hover specificity**: Individual hover rules override generic ones
4. **Color preservation**: Each button maintains its unique color scheme

#### Layout Stability Principles
- **Never change**: `margin`, `padding`, `font-size`, `width`, `height` in hover/animations
- **Safe to change**: `box-shadow`, `background`, `border`, `opacity`, `color`
- **Test thoroughly**: Any hover effect that might affect neighboring elements