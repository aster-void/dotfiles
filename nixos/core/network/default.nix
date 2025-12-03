{host, ...}: {
  imports = [
    ./dns.nix
    ./mdns.nix
    ./gvfs.nix
  ];

  networking = {
    # Enable networking
    networkmanager.enable = true;
    hostName = "${host}"; # Define your hostname.

    firewall = {
      enable = true;
      # 53317: localsend
      allowedTCPPorts = [53317];
      allowedUDPPorts = [53317];
    };
  };
}
