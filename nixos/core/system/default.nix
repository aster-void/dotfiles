{pkgs, ...}: {
  # Swappiness
  boot.kernel.sysctl = {
    "vm.swappiness" = 60;
  };

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  programs.nix-ld.enable = true;

  # Dbus
  services.dbus.enable = true;
}
