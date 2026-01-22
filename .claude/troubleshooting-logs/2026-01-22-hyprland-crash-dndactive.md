# Hyprland Crash - dndActive SIGSEGV

## Summary

Hyprland 0.52.1 crashes with SIGSEGV after boot. Occurred on 2026-01-21 and 2026-01-22.

## Environment

- **Hyprland version**: 0.52.1
- **nixpkgs branch**: nixos-25.11
- **Host**: azalea

## Crash Details

- **Signal**: SIGSEGV (11)
- **Location**: `CWLDataDeviceProtocol::dndActive()`
- **Trigger**: Unknown - user was not performing any specific action

### Stack Trace

```
#0  CWLDataDeviceProtocol::dndActive()
#1  CSeatManager::setPointerFocus()
#2  [lambda in CSeatManager::setPointerFocus()]
#3  CSignalListener::emitInternal()
#4  CSignalBase::emitInternal()
#5  CWLSurfaceResource::~CWLSurfaceResource()  <- destructor
#6  CSharedPointer<CWLSurfaceResource>::_delete()
#7  CUniquePointer<CSurfacePassElement>::[destructor lambda]
#8  CUniquePointer<CRenderPass::SPassElementData>::[destructor lambda]
#9  CHyprRenderer::~CHyprRenderer()
#10 CUniquePointer<CHyprRenderer>::[destructor lambda]
#11 CCompositor::cleanup()
#12 main
```

## Analysis

The crash occurs during surface resource destruction. When `CWLSurfaceResource` destructor runs, it emits a signal that triggers `setPointerFocus()`, which then calls `dndActive()` on potentially invalid DnD state.

This appears to be a use-after-free or null pointer dereference in drag-and-drop protocol handling during cleanup.

## Related Issues

- PR #8707: "core/data: Use pointer focus for DnD operations" (merged in v0.46.0)
- Hyprland 0.53.1 includes stability and crash fixes

## Resolution Status

**Pending** - Waiting for Hyprland 0.53.1 to reach nixos-25.11 branch.

### Why not upgrade now?

- **Hyprland flake**: Requires compilation (no cache)
- **nixpkgs unstable**: Unstable due to GCC 15 migration

## Actions Taken

1. Enabled Hyprland debug logs (`debug.disable_logs = false`)
2. Committed: `384a8b9 modules/desktop: enable hyprland debug logs`

## Next Steps

1. Monitor for crashes with debug logs enabled
2. Check `/tmp/hypr/<instance>/hyprland.log` on next crash
3. Periodically check if 0.53.1 reaches nixos-25.11:
   ```sh
   nix-search hyprland  # or check https://search.nixos.org
   ```
