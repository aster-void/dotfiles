# Voxtype push-to-talk STT setup on KDE Wayland (non-NixOS)

## ROOT CAUSE
Setting up speech-to-text with push-to-talk on KDE Plasma Wayland (Nobara/Fedora) using nix-managed voxtype. Multiple interacting issues: keyd key interception, nix/system driver mismatch, ALSA plugin paths, and Wayland text injection limitations.

## TRIALS

### 1. Custom whisper-ptt Python daemon
- **What**: Built a custom PTT daemon using whisper-cli + evdev + ydotool
- **Why failed**: Too many moving parts. ydotool can't type Unicode/Japanese. wtype doesn't work on KDE (no `zwp_virtual_keyboard_v1` support). keyd remaps ydotool's virtual keyboard output through workman layout, turning Ctrl+V into Ctrl+C.

### 2. Voxtype (existing Rust tool) — initial setup
- **What**: Switched to voxtype with Right Ctrl hotkey
- **Why failed**: keyd normalizes rightcontrol → leftcontrol internally. No config can prevent this. Changed to F10 which keyd passes through correctly.

### 3. voxtype-vulkan SEGV on nix
- **What**: voxtype-vulkan from nixpkgs crashed with SIGSEGV during whisper GPU init
- **Why failed**: nix's vulkan loader couldn't find system NVIDIA drivers
- **Fix**: Set `VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/nvidia_icd.x86_64.json` and `LD_LIBRARY_PATH=/usr/lib64` in systemd Environment. This lets nix's voxtype-vulkan use system NVIDIA Vulkan ICD.

### 4. ALSA "No such device" in systemd service
- **What**: voxtype couldn't open audio device — `libasound_module_pcm_pipewire.so` not found
- **Why failed**: nix's ALSA lib looks for pipewire PCM plugin in its own store path, but it's not there
- **Fix**: `ALSA_PLUGIN_DIR=${pkgs.pipewire}/lib/alsa-lib` in systemd Environment

### 5. CPU model too slow
- **What**: large-v3-turbo on CPU took >30 seconds for 1.8s audio, never returned
- **Fix**: Switched to voxtype-vulkan (GPU). 0.4-0.5s transcription time.

### 6. voxtype "All output methods failed" in systemd but works manually
- **What**: clipboard mode fails when run as systemd service, works when run from terminal
- **Why failed**: Unclear root cause. voxtype's nix wrapper sets its own PATH with wl-copy/dotool/wtype, and all tools are present. Possibly related to systemd service environment vs interactive shell. Workaround: run voxtype from wrapper script in systemd (which inherits graphical session env properly).

### 7. Text output: dotool types but nothing appears
- **What**: dotool reported "21 chars typed" but no text appeared
- **Why failed**: dotool can't type Unicode/Japanese characters — `WARNING: impossible character for layout: テ`

### 8. Text output: ydotool Ctrl+V → Ctrl+C
- **What**: ydotool sends keycode 47 (v), keyd workman layout remaps v→c
- **Fix**: Exclude ydotool device `-2333:6666` in keyd `[ids]` section. Also exclude dotool `-4711:0815`.

### 9. Ctrl+V doesn't work in terminals
- **What**: Auto-paste via ydotool Ctrl+V works in Discord but not Ghostty/Zen
- **Fix**: Changed to Ctrl+Shift+V (keycode 29+42+47). Works in terminals (paste) and GUI apps (paste without formatting). Plain text anyway so no difference.

### 10. nixpkgs version: voxtype not in stable
- **What**: `voxtype-vulkan` not found in nixos-25.11
- **Fix**: Upgraded to `nixpkgs-unstable` and `home-manager/master`

## TAKEAWAY

### nix on non-NixOS: GPU/audio driver gaps
- Vulkan: nix binaries can't find system GPU drivers. Must set `VK_ICD_FILENAMES` to system ICD and `LD_LIBRARY_PATH=/usr/lib64`.
- ALSA/PipeWire: nix's ALSA can't find system pipewire PCM plugin. Must set `ALSA_PLUGIN_DIR` to nix's pipewire path.
- These are recurring patterns for any nix-managed multimedia app on non-NixOS.

### keyd quirks
- keyd normalizes rightcontrol → leftcontrol. Can't be overridden with mapping.
- keyd grabs ALL devices by default (`[ids] *`). Virtual keyboards (ydotool `2333:6666`, dotool `4711:0815`) must be explicitly excluded or their output gets remapped.
- Device IDs for virtual keyboards: check `/proc/bus/input/devices` (dotool's device is ephemeral — need to catch it while active).

### Wayland text injection on KDE: unsolved problem
- wtype: KDE doesn't support `zwp_virtual_keyboard_v1`
- dotool/ydotool: can't type Unicode/CJK characters (ASCII keycodes only)
- KWtype: uses KDE Fake Input protocol but requires authentication that's hard to grant
- fcitx5 DBus: no external CommitString method (security by design)
- XDG RemoteDesktop portal: only sends keysyms, not text
- **Everyone uses clipboard mode**. Telly Spelly, voxtype, waystt — all clipboard-based.
- Best workaround: clipboard + Ctrl+Shift+V auto-paste via ydotool (works in most apps)

### Final architecture
```
F10 (hold) → voxtype-vulkan (GPU whisper large-v3-turbo, 0.5s)
  → wl-copy to clipboard
  → inotifywait on state file
  → ydotool Ctrl+Shift+V auto-paste
```
Services: ydotoold → voxtype (wrapper with autopaste subshell)
