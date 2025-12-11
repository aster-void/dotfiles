{pkgs, ...}: {
  # Basic networking setup
  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "systemd-resolved";

  # Fast DNS resolution with Cloudflare and Google
  services.resolved = {
    enable = true;
    dnssec = "false";
    domains = ["~."];
    fallbackDns = ["1.1.1.1" "8.8.8.8"];
    extraConfig = ''
      DNS=1.1.1.1#cloudflare-dns.com 8.8.8.8#dns.google
      DNSOverTLS=opportunistic
    '';
  };

  environment.systemPackages = with pkgs; [
    cloudflared
    cloudflare-cli
  ];

  # mDNS discovery for local network
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
      domain = true;
      workstation = true;
    };
  };
}
