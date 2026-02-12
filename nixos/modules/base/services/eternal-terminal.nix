{...}: {
  # Eternal Terminal - SSH alternative with auto-reconnect
  services.eternal-terminal.enable = true;

  # Default port is 2022
  networking.firewall.allowedTCPPorts = [2022];
}
