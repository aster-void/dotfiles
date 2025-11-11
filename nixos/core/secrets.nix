{config, ...}: let
  inherit (config.age) secrets;
in {
  age.identityPaths = [
    "/home/aster/.ssh/id_ed25519"
    "/root/.ssh/id_ed25519"
  ];
  age.secrets.nix-access-tokens-conf = {
    file = ../../secrets/nix.conf.age;
    group = "users";
    mode = "600";
  };

  nix.extraOptions = ''
    !include ${secrets.nix-access-tokens-conf.path}
  '';
}
