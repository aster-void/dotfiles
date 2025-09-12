{meta, ...}: {
  # Define a user account.
  users.users.${meta.username} = {
    isNormalUser = true;
    description = meta.username;
    extraGroups = [
      "mlocate"
      "networkmanager"
      "wheel"
      "docker"
      "video"
    ];
  };
}
