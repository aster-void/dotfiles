{config, ...}: let
  wifiSecret = config.age.secrets."azalea-wifi-pass";
in {
  age.secrets."azalea-wifi-pass" = {
    file = ../../../secrets/wifi/azalea-wifi.age;
    owner = "root";
    group = "root";
    mode = "0400";
  };

  networking.networkmanager.unmanaged = ["wlp4s0"];

  systemd.network = {
    enable = true;
    networks."30-wlp4s0" = {
      matchConfig.Name = "wlp4s0";
      address = ["10.89.0.1/24"];
      networkConfig.DHCPServer = false;
    };
  };

  services.hostapd = {
    enable = true;
    radios.wlp4s0 = {
      band = "2g";
      channel = 6;
      countryCode = "JP";
      networks.wlp4s0 = {
        ssid = "azalea";
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
      interface = "wlp4s0";
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
    externalInterface = "enp3s0";
    internalInterfaces = ["wlp4s0"];
  };
}
