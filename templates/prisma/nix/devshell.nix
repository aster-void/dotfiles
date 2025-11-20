{
  pkgs,
  inputs,
}: let
  prisma = inputs.nix-prisma-utils.lib.prisma-factory {
    inherit pkgs;
    hash = "sha256-JWX+N/mmp9uJLcv4XFbQ3yg34fFf2BLIUpOLrrfTjEM=";
    bunLock = ../bun.lock;
  };
in
  pkgs.mkShell {
    inherit (prisma) env;
    packages = [
      pkgs.bun
      pkgs.nodejs
    ];
  }
