{
  pkgs,
  lib,
  ...
}: let
  cloudflared = lib.getExe' pkgs.cloudflared "cloudflared";
in {
  programs.ssh = {
    extraConfig = ''
      Host carbon.aster-void.dev
        ProxyCommand ${cloudflared} access ssh --hostname %h
        User root
    '';
  };
}
