{pkgs, ...}: {
  services.cloudflare-warp.enable = true;

  programs.ssh = {
    extraConfig = ''
      Host workspace.aster-void.dev
        Port 2222

      Host fhs.workspace.aster-void.dev
        Port 2223

      Host *.aster-void.dev
        ProxyCommand ${pkgs.lib.getExe' pkgs.cloudflared "cloudflared"} access ssh --hostname %h --destination localhost:%p
    '';
  };
}
