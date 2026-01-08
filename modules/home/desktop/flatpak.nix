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
