{host, ...}: {
  networking = {
    hostName = "${host}"; # Define your hostname.

    nameservers = [
      # cloudflare
      "1.1.1.1"
      "1.0.0.1"
      # quad9
      "9.9.9.9"
      # google
      "8.8.8.8"
      "8.8.4.4"
    ];

    # Open ports in the firewall.
    firewall = {
      enable = true;
      allowedTCPPorts = [53317];
      allowedUDPPorts = [53317];
    };

    # Enable networking
    networkmanager.enable = true;
  };

  services.resolved.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    ipv4 = true;
    ipv6 = true;
    publish = {
      enable = true;
      workstation = true;
    };
  };

  systemd.services.avahi-daemon = {
    after = ["network-online.target"];
    wants = ["network-online.target"];
  };
}
