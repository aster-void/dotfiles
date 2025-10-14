{
  my,
  config,
  lib,
  ...
}: {
  imports = [
    ./services
  ];
  config = let
    cfg = config.my.shell.glue;
  in
    lib.mkIf cfg.enable {
      home.packages = with my.pkgs; [
        wpick
      ];
    };
}
