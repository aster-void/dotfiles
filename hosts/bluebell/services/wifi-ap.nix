{config, ...}: let
  wifiSecret = config.age.secrets."wifi-password";
in {
  age.secrets."wifi-password" = {
    file = ../../../secrets/wifi/password.age;
    owner = "root";
    group = "root";
    mode = "0400";
  };

  networking.networkmanager.unmanaged = ["wlo1"];

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
