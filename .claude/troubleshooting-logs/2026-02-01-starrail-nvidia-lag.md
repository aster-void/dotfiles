# Star Rail lagging - NVIDIA driver not loading in Flatpak

## ROOT CAUSE
Flatpak NVIDIA GL runtime version (`580.119.02`) did not match the system NVIDIA driver version (`580.126.09`). This prevented the game from accessing the GPU inside the flatpak sandbox — Star Rail was not appearing in `nvidia-smi` processes at all.

## TRIALS

### Check nvidia-smi for game process
- **What**: Ran `nvidia-smi` while game was running
- **Why it worked**: Star Rail was absent from GPU process list, confirming it wasn't using the GPU

### Compare flatpak GL runtime vs system driver
- **What**: `flatpak list --runtime | grep nvidia` vs `nvidia-smi` driver version
- **Why it worked**: Revealed mismatch — flatpak had `580-119-02`, system had `580.126.09`

### flatpak update
- **What**: `flatpak update` pulled in `org.freedesktop.Platform.GL.nvidia-580-126-09` (and GL32 variant), removed old `580-119-02`
- **Why it worked**: Matched the flatpak runtime to the system driver, restoring GPU access

## TAKEAWAY
- When a game runs via Flatpak + Wine/Proton and lags badly, check for **flatpak NVIDIA GL runtime version mismatch** with the system driver first. This is a common issue after system NVIDIA driver updates.
- Quick diagnostic: if the game PID is missing from `nvidia-smi` output, the GPU isn't being used.
- Fix: `flatpak update` or manually `flatpak install org.freedesktop.Platform.GL.nvidia-<version>`.
