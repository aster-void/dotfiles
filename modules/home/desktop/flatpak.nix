{
  services.flatpak = {
    enable = true;
    uninstallUnmanaged = true;
    remotes = [
      {
        name = "flathub";
        location = "https://flathub.org/repo/flathub.flatpakrepo";
      }
    ];
    overrides = {
      global = {
        Context.filesystems = [
          "host-etc"
          "~/.config/fontconfig:ro"
          "/nix/store:ro"
        ];
        Environment = {
          FONTCONFIG_FILE = "/home/aster/.config/fontconfig/flatpak-fonts.conf";
        };
      };
    };
    packages = [
      # Browsers
      "com.brave.Browser"

      # Communication
      "com.discordapp.Discord"
      "com.slack.Slack"
      "us.zoom.Zoom"

      # Utilities
      "com.github.tchx84.Flatseal"

      # Runtime
      "org.gnome.Platform//45"
    ];
  };
}
