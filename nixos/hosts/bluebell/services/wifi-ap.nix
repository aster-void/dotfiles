{
  config,
  lib,
  flake,
  ...
}: let
  wifiSecret = config.age.secrets."wifi-password";
in {
  age.secrets."wifi-password" = {
    file = "${flake}/secrets/wifi/password.age";
    owner = "root";
    group = "root";
    mode = "0400";
  };

  networking.networkmanager.unmanaged = ["wlo1"];
  networking.wireless.enable = lib.mkForce false; # avoid conflict with hostapd on wlo1

  systemd.network = {
    enable = true;
    networks."30-wlo1" = {
      matchConfig.Name = "wlo1";
      address = ["10.89.0.1/24"];
      networkConfig.DHCPServer = false;
    };
  };

  services.hostapd = {
    enable = true;
    radios.wlo1 = {
      band = "2g";
      channel = 6;
      countryCode = "JP";
      networks.wlo1 = {
        ssid = "bluebell";
        authentication = {
          mode = "wpa3-sae-transition";
          saePasswordsFile = wifiSecret.path;
          wpaPasswordFile = wifiSecret.path;
        };
      };
    };
  };

  # Wait for wlo1 interface to be ready before starting dnsmasq
  systemd.services.dnsmasq = {
    after = ["sys-subsystem-net-devices-wlo1.device" "hostapd.service"];
    bindsTo = ["sys-subsystem-net-devices-wlo1.device"];
  };

  services.dnsmasq = {
    enable = true;
    settings = {
      interface = "wlo1";
      bind-interfaces = true;
      domain-needed = true;
      bogus-priv = true;
      dhcp-range = "10.89.0.10,10.89.0.100,12h";
      dhcp-option = [
        "3,10.89.0.1"
        "6,1.1.1.1"
      ];
      server = ["1.1.1.1"];
    };
  };

  networking.firewall.allowedTCPPorts = [53];
  networking.firewall.allowedUDPPorts = [53 67 68];

  networking.nat = {
    enable = true;
    externalInterface = "eno2";
    internalInterfaces = ["wlo1"];
  };
}
