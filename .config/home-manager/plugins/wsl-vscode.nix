{ lib, config, pkgs, ... }:
let
  cfg = config.nixos-wsl-vscode;
in
{
  options.nixos-wsl-vscode = {
    enable = lib.mkEnableOption "Enable VS Code in NixOS WSL";
  };

  ## README: you need to install wget too.
  config = lib.mkIf cfg.enable {
    # environment.variables = ldEnv;
    home.file.".vscode-server/server-env-setup".source = "${pkgs.fetchFromGitHub {
      owner = "sonowz";
      repo = "vscode-remote-wsl-nixos";
      rev = "55ba0a5969763fecfa10d194a8ab76caa42774cf";
      hash = "sha256-m18X5GZPrKKNyNDg4Xy4wjd076gMA+sb+pLuMzFGDPE=";
    }}/server-env-setup";
  };
}


