{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.my.shell.caelestia;
  caelestia-cli = inputs.caelestia-cli.packages.${pkgs.system}.with-shell;
in {
  config = lib.mkIf cfg.enable {
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
        After = ["graphical-session.target" "wayland-session@Hyprland.target"];
        Wants = ["graphical-session.target"];
        Requisite = ["wayland-session@Hyprland.target"];
      };
      Service = {
        Type = "simple";
        ExecStart = "${lib.getExe caelestia-cli} shell";
        Restart = "on-failure";
        RestartSec = 3;
        Environment = [
          "XDG_DATA_DIRS=%h/.local/share:%h/.nix-profile/share:/etc/profiles/per-user/%u/share:/run/current-system/sw/share"
        ];
      };
      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };
  };
}
