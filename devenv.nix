{
  inputs,
  pkgs,
  ...
}: {
  env.RULES = "./nixos/secrets/secrets.nix";

  packages = with pkgs; [
    inputs.agenix.packages.${stdenv.hostPlatform.system}.default
    lefthook
    alejandra
    bun
    python3
  ];

  enterShell = ''
    lefthook install
  '';
}
