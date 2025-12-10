{
  config,
  lib,
  pkgs,
  flake,
  inputs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) system;
  cfg = config.my.desktop.shells.caelestia;
  caelestia-cli = inputs.caelestia-cli.packages.${system}.with-shell;
in {
  config = lib.mkIf cfg.enable {
    home.packages = [
      inputs.caelestia-shell.packages.${system}.with-cli
      inputs.caelestia-cli.packages.${system}.with-shell
      # wpick with caelestia commands - for now just use default wpick
      flake.packages.${system}.wpick
    ];

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
        ExecStartPre = "${lib.getExe' pkgs.coreutils "sleep"} 3";
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

    # Caelestia configuration files
    xdg.configFile = {
      "caelestia/cli.json".text = builtins.toJSON {
        theme = {
          enableTerm = false;
          enableHypr = false;
          enableDiscord = false;
          enableSpicetify = false;
          enableFuzzel = false;
          enableBtop = false;
          enableGtk = false;
          enableQt = false;
        };
      };

      "caelestia/shell.json".text = builtins.toJSON {
        services = {
          useFahrenheit = false;
        };
        background = {
          enabled = true;
          desktopClock = {
            enabled = true;
          };
        };
        bar = {
          clock = {
            showIcon = false;
          };
          status = {
            showAudio = true;
            showBattery = true;
            showBluetooth = true;
            showKbLayout = false;
            showMicrophone = true;
            showNetwork = true;
            showLockStatus = true;
          };
          workspaces = {
            activeIndicator = true;
            activeLabel = "";
            activeTrail = true;
            label = "";
            occupiedBg = true;
            occupiedLabel = "";
            perMonitorWorkspaces = true;
            showWindows = false;
            shown = 5;
            specialWorkspaceIcons = [
              {
                name = "steam";
                icon = "sports_esports";
              }
            ];
          };
        };
        "notifs.actionOnClick" = true;
        paths = {
          mediaGif = "root:/assets/bongocat.gif";
          sessionGif = "root:/assets/kurukuru.gif";
          wallpaperDir = "~/decorations/images";
        };
      };
    };
  };
}
