{pkgs, ...}: {
  services.cloudflare-warp.enable = true;

  # SSH設定
  programs.ssh = {
    extraConfig = ''
      Host *.aster-void.dev
        ProxyCommand ${pkgs.lib.getExe' pkgs.cloudflared "cloudflared"} access ssh --hostname %h
    '';
  };
}
