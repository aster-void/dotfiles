{pkgs, ...}: {
  # Swappiness
  boot.kernel.sysctl = {
    "vm.swappiness" = 60;
  };

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_6_6;

  programs.nix-ld.enable = true;

  # Dbus
  services.dbus.enable = true;
}
