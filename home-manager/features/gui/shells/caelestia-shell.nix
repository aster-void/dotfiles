{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.my.shell;
in {
  config = lib.mkIf (cfg.enable && cfg.type == "caelestia-shell") {
    home.packages = [
      inputs.caelestia-shell.packages.${pkgs.system}.with-cli
      inputs.caelestia-cli.packages.${pkgs.system}.with-shell
    ];

    home.file.".config/caelestia/shell.json".text = builtins.toJSON {
      services = {
        useFahrenheit = false;
      };
    };

    systemd.user.services.caelestia-shell = {
      Unit = {
        Description = "Caelestia Shell - Quickshell based desktop shell";
        PartOf = ["graphical-session.target"];
        After = ["graphical-session.target"];
        Wants = ["graphical-session.target"];
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.bash}/bin/bash -c 'caelestia shell'";
        Restart = "on-failure";
        RestartSec = 3;
      };
      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };
  };
}
