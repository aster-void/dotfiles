{...}: {
  # Enable Wake-on-LAN for all ethernet interfaces
  systemd.network.links."99-wol" = {
    matchConfig.Type = "ether";
    linkConfig.WakeOnLan = "magic";
  };
}
