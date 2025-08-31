{shared, ...}: let
  inherit (shared.config) mkShellAliases;
in {
  programs = {
    bash = {
      enable = true;
      shellAliases = mkShellAliases "bash";
      enableCompletion = false;
    };

    nushell = {
      enable = true;
      shellAliases = mkShellAliases "nushell";
    };

    starship = {
      enable = true;
      settings = import ./starship.nix;
    };
    zoxide = {
      enable = true;

      enableBashIntegration = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
    };

    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };

    fish = {
      enable = true;
      shellAliases = mkShellAliases "fish";
    };
  };
}
