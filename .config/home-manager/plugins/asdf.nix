{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.programs.asdf;
in {
  options.programs.asdf = {
    enable = lib.mkEnableOption "asdf version manager";
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.asdf-vm;
    };
  };

  config = lib.mkIf cfg.enable {
    programs.bash.initExtra = ''
      . "${cfg.package}/share/asdf-vm/asdf.sh"
    '';
  };
}
