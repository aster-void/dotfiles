{meta, ...}: let
  inherit (meta) username;
in {
  nixpkgs.config.allowUnfree = true;
  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "24.11";

    sessionVariables = {
      EDITOR = "hx";
      BROWSER = "zen-beta";
      TERMINAL = "alacritty";
      NIXOS_OZONE_WL = 1;
    };
  };
}
