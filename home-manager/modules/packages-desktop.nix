{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];

  home.packages = with pkgs; [
    # gui apps
    blueberry
    winboat

    # terminal utils that only make sense in gui env
    wl-clipboard
    ydotool

    voxtype-vulkan
  ];

  systemd.user.services.ydotoold = {
    Unit = {
      Description = "ydotool daemon";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.ydotool}/bin/ydotoold";
      Restart = "on-failure";
      RestartSec = 3;
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  systemd.user.services.voxtype = {
    Unit = {
      Description = "Voxtype push-to-talk voice-to-text with auto-paste";
      After = [
        "graphical-session.target"
        "ydotoold.service"
      ];
      PartOf = [ "graphical-session.target" ];
      Requires = [ "ydotoold.service" ];
    };
    Service = {
      Type = "simple";
      Environment = [
        # ALSA needs the pipewire PCM plugin to reach PipeWire on non-NixOS
        "ALSA_PLUGIN_DIR=${pkgs.pipewire}/lib/alsa-lib"
        # Use system NVIDIA Vulkan ICD instead of nix's (which can't find the driver)
        "VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/nvidia_icd.x86_64.json"
        "LD_LIBRARY_PATH=/usr/lib64"
        "YDOTOOL_SOCKET=/run/user/1000/.ydotool_socket"
      ];
      # Wrapper: runs voxtype (clipboard mode) + watches state file to auto-paste via ydotool
      ExecStart = "${pkgs.writeShellScript "voxtype-wrapper" ''
        STATE="/run/user/1000/voxtype/state"

        # Auto-paste: watch state file, Ctrl+Shift+V when transcription completes
        # Ctrl+Shift+V works in both terminals (paste) and GUI apps (paste without formatting)
        (
          sleep 2  # wait for voxtype to create state file
          prev=""
          while true; do
            ${pkgs.inotify-tools}/bin/inotifywait -qq -e modify "$STATE" 2>/dev/null
            cur=$(cat "$STATE" 2>/dev/null)
            if [ "$prev" = "transcribing" ] && [ "$cur" = "idle" ]; then
              sleep 0.05
              ${pkgs.ydotool}/bin/ydotool key 29:1 42:1 47:1 47:0 42:0 29:0
            fi
            prev="$cur"
          done
        ) &

        exec ${pkgs.voxtype-vulkan}/bin/voxtype
      ''}";
      Restart = "on-failure";
      RestartSec = 5;
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  # Mask the auto-generated XDG autostart unit — it races with the graphical
  # session and crashes because WAYLAND_DISPLAY isn't available yet.
  # We replace it with our own service below that has proper ordering.
  systemd.user.services."app-org.kde.xwaylandvideobridge@autostart" = {
    Unit.Description = "Mask auto-generated xwaylandvideobridge autostart";
    Install = { };
  };

  systemd.user.services.xwaylandvideobridge = {
    Unit = {
      Description = "Xwayland Video Bridge";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "/usr/bin/xwaylandvideobridge";
      Restart = "on-failure";
      RestartSec = 3;
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  systemd.user.services.flatpak-managed-install.Service.TimeoutStartSec = "10m";

  # Workaround: nix-flatpak uses nixpkgs' flatpak binary, which hardcodes
  # /run/current-system/sw/bin/flatpak into DBus service files. This path
  # doesn't exist on non-NixOS (e.g. Fedora), so DBusActivatable apps fail
  # to launch from the app menu. This service patches the exported DBus
  # service files to use the actual flatpak binary path.
  # See: https://github.com/NixOS/nixpkgs/issues/138956
  systemd.user.services.flatpak-fix-dbus-paths = {
    Unit = {
      Description = "Fix flatpak DBus service file paths";
      After = [ "flatpak-managed-install.service" ];
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.writeShellScript "fix-flatpak-dbus-paths" ''
        src="$HOME/.local/share/flatpak/exports/share/dbus-1/services"
        dst="$HOME/.local/share/dbus-1/services"

        [ -d "$src" ] || exit 0

        flatpak_bin=""
        for candidate in /usr/bin/flatpak /run/current-system/sw/bin/flatpak; do
          if [ -x "$candidate" ]; then
            flatpak_bin="$candidate"
            break
          fi
        done
        [ -n "$flatpak_bin" ] || exit 1

        mkdir -p "$dst"
        for f in "$src"/*.service; do
          [ -f "$f" ] || continue
          ${pkgs.gnused}/bin/sed "s|Exec=[^ ]*/flatpak |Exec=$flatpak_bin |" "$f" > "$dst/$(basename "$f")"
        done
      ''}";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  services.flatpak.enable = true;
  services.flatpak.remotes = [
    {
      name = "flathub";
      location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
    }
    {
      name = "flathub-beta";
      location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
    }
  ];
  services.flatpak.overrides = {
    global.Context.filesystems = [
      "xdg-config/fontconfig:ro"
      "~/.local/share/fonts:ro"
      "/nix/store:ro" # HM fontconfig symlinks point into nix store
    ];
    "app.zen_browser.zen".Context.filesystems = [
      "xdg-run/speech-dispatcher:ro"
    ];
  };
  services.flatpak.packages = [
    # Browser & Communication
    "app.zen_browser.zen"
    "com.google.ChromeDev"

    # Documents
    "md.obsidian.Obsidian"

    # Communication
    "com.discordapp.Discord"
    "com.slack.Slack"
    "org.telegram.desktop"

    # Application Manager & System
    "com.github.tchx84.Flatseal"
    "it.mijorus.gearlever"
    "com.usebottles.bottles"
    "com.valvesoftware.Steam"

    # File viewer
    # == pictures
    "org.gnome.eog"
    "org.gnome.gThumb"

    # == music
    "io.bassi.Amberol"
    "com.github.neithern.g4music"

    # Audio
    "com.github.wwmm.easyeffects"
  ];
}
