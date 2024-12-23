{ pkgs, ... }: {
  xdg.desktopEntries = {
    slack = {
      name = "Slack";
      exec = "slack --enable-wayland-ime %U";
      icon = "${pkgs.slack}/share/pixmaps/slack.png";
    };
    discord = {
      name = "Discord";
      exec = "discord --enable-wayland-ime %U";
      icon = "${pkgs.discord}/share/pixmaps/discord.png";
    };
  };
}
