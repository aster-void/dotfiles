{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../../profiles/desktop.nix
    ../../modules/hardware/bootloader/grub.nix
  ];

  # Host-specific hardware configuration
  hardware.graphics.enable = true;
  hardware.graphics.extraPackages = [pkgs.intel-media-driver];

  # Host-specific packages
  environment.systemPackages = with pkgs; [prismlauncher];
}
