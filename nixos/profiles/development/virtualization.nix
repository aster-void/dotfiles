{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.profiles.development;
in {
  # Virtualization
  virtualisation = lib.mkIf cfg.enable {
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
    podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    waydroid.enable = true;
  };

  # Additional development packages
  environment = lib.mkIf cfg.enable {
    systemPackages = with pkgs; [
      # virt
      kubernetes
      kubectl
      k3s
    ];
  };
}
