{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.programs.asdf;
  mkIntegrationOption = name:
    lib.mkOption {
      type = lib.types.bool;
      description = "Whether to enable ${name} integration";
      default = true;
      example = false;
    };
in {
  options.programs.asdf = {
    enable = lib.mkEnableOption "asdf version manager";
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.asdf-vm;
    };
    enableBashIntegration = mkIntegrationOption "bash";
    enableZshIntegration = mkIntegrationOption "zsh";
    enableFishIntegration = mkIntegrationOption "fish";
  };

  config = lib.mkIf cfg.enable {
    # NOTE: not adding asdf-vm to home.packages because asdf seems to download its own bin under /share rather than under /bin

    programs = {
      bash.initExtra = lib.optionalString cfg.enableBashIntegration ''
        source "${cfg.package}/share/asdf-vm/asdf.sh"
      '';

      zsh.initExtra = lib.optionalString cfg.enableZshIntegration ''
        source "${cfg.package}/share/asdf-vm/asdf.sh"
      '';

      fish.shellInitLast = lib.optionalString cfg.enableFishIntegration ''
        source "${cfg.package}/share/asdf-vm/asdf.fish"
      '';
    };
  };
}
