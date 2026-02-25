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
    wezterm

    # terminal utils that only make sense in gui env
    wl-clipboard
  ];

  systemd.user.services.flatpak-managed-install.Service.TimeoutStartSec = "10m";

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
    ];
    "app.zen_browser.zen".Context.filesystems = [
      "xdg-run/speech-dispatcher:ro"
    ];
  };
  services.flatpak.packages = [
    "app.zen_browser.zen"
    "com.discordapp.Discord"
    "com.slack.Slack"
    "com.github.tchx84.Flatseal"
    "com.google.ChromeDev"
    "com.usebottles.bottles"
    "com.valvesoftware.Steam"
    "it.mijorus.gearlever"
    "md.obsidian.Obsidian"
    "org.gnome.eog"
  ];
}
