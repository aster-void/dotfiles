# Intel I225-V Ethernet Not Waking After Sleep

## Problem

After system sleep/suspend, the Intel I225-V ethernet controller (`enp3s0`) does not recover. `ip link` shows `state DOWN` and `CARRIER: off` even with cable connected.

## Symptoms

- `nmcli device show enp3s0` shows `CARRIER: off`
- `ip link set enp3s0 up` fails with "no such device"
- Interface appears in `ip link` but driver is not functional

## Root Cause

Intel I225-V (igc driver) has known power management issues. The driver fails to properly restore state after suspend/resume, likely due to PCIe ASPM (Active State Power Management) interactions.

## Manual Recovery

Reload the `igc` driver:

```bash
sudo modprobe -r igc && sudo modprobe igc
```

If that fails, PCI reset:

```bash
pci_path=$(ls -d /sys/bus/pci/drivers/igc/0000:* | head -1)
sudo sh -c "echo 1 > $pci_path/remove"
sudo sh -c "echo 1 > /sys/bus/pci/rescan"
```

## Permanent Fix

See `hosts/azalea/fixes.nix`:

1. **ASPM policy** - Set to `performance` to disable aggressive power states
2. **udev rule** - Disable runtime PM for igc devices
3. **systemd service** - Auto-reload driver on resume with PCI reset fallback

## References

- [Intel Support Article 000093326](https://www.intel.com/content/www/us/en/support/articles/000093326/ethernet-products/gigabit-ethernet-controllers-up-to-2-5gbe.html)
- [Workaround for Intel I226-V](https://blog.cordx.cx/posts/2024-09-19-intel-net-cont-problem)
