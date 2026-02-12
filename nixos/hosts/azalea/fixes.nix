# Intel I225-V (igc) power management issues
# See .claude/troubleshooting-logs/2026-01-13-intel-i225v-not-waking-after-sleep.md
{pkgs, ...}: {
  # Disable ASPM for igc to prevent power state issues
  boot.kernelParams = ["pcie_aspm.policy=performance"];

  # Disable runtime PM (prevents random disconnects)
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="net", DRIVERS=="igc", ATTR{device/power/control}="on"
  '';

  # Reload driver after suspend with PCI reset fallback
  systemd.services.igc-resume = {
    description = "Reload igc driver after suspend";
    after = ["suspend.target" "hibernate.target" "hybrid-sleep.target"];
    wantedBy = ["suspend.target" "hibernate.target" "hybrid-sleep.target"];
    serviceConfig.Type = "oneshot";
    path = [pkgs.kmod pkgs.pciutils];
    script = ''
      modprobe -r igc
      modprobe igc || {
        # Fallback: PCI reset if modprobe fails
        pci_path=$(ls -d /sys/bus/pci/drivers/igc/0000:* 2>/dev/null | head -1)
        if [ -n "$pci_path" ]; then
          echo 1 > "$pci_path/remove"
          echo 1 > /sys/bus/pci/rescan
        fi
      }
    '';
  };
}
