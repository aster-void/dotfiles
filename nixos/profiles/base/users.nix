{shared, ...}: {
  # User configuration for base system
  users.users.${shared.system.user} = {
    description = "Primary user";
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  security.polkit.enable = true;
}
