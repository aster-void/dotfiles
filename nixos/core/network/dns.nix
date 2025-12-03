{
  networking.nameservers = [
    # cloudflare
    "1.1.1.1"
    "1.0.0.1"
    # quad9
    "9.9.9.9"
    # google
    "8.8.8.8"
    "8.8.4.4"
  ];
  services.resolved = {
    enable = true;
    dnssec = "false"; # ルーターのDNSSEC非対応問題を回避
    fallbackDns = [
      "1.1.1.1"
      "1.0.0.1"
      "9.9.9.9"
      "8.8.8.8"
      "8.8.4.4"
    ];
  };
}
