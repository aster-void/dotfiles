{pkgs, ...}: {
  # Desktop workstation with Intel graphics
  imports = [
    ./bogster-hardware.nix
    ../profiles/desktop
    ../profiles/gaming
    ../hardware/bootloaders/grub.nix
  ];

  # Enable gaming profile
  profiles.gaming.enable = true;

  # Host-specific hardware configuration
  hardware.graphics = {
    enable = true;
    extraPackages = [pkgs.intel-media-driver];
  };

  # Host-specific packages
  environment.systemPackages = with pkgs; [
    prismlauncher
  ];
}
