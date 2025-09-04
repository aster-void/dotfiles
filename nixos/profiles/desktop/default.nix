{shared, ...}: {
  # Desktop workstation profile
  imports = [
    ../base
    ./display-manager.nix
    ./hyprland.nix
    ./applications.nix
    ./audio.nix
  ];

  # Desktop-specific user groups
  users.users.${shared.system.user}.extraGroups = [
    "audio"
    "video"
    "input"
    "storage"
  ];
}
