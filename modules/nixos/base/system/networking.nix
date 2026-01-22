{pkgs, ...}: {
  # Basic networking setup
  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "systemd-resolved";

  # Fast DNS resolution with Cloudflare and Google
  services.resolved = {
    enable = true;
    settings.Resolve = {
      DNSSEC = "false";
      Domains = ["~."];
      FallbackDNS = ["1.1.1.1" "8.8.8.8"];
      DNS = ["1.1.1.1#cloudflare-dns.com" "8.8.8.8#dns.google"];
      DNSOverTLS = "opportunistic";
      MulticastDNS = false;
    };
  };

  networking.firewall.enable = true;

  environment.systemPackages = with pkgs; [
    cloudflared
    cloudflare-cli
    iw
  ];

  # mDNS discovery for local network
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    nssmdns6 = true;
    publish = {
      enable = true;
      addresses = true;
      domain = true;
      workstation = true;
    };
  };
}
