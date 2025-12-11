{
  inputs,
  pkgs,
  ...
}: {
  env.RULES = "./secrets/secrets.nix";

  packages = with pkgs; [
    inputs.agenix.packages.${stdenv.system}.default
    lefthook
    alejandra
    bun
  ];

  enterShell = ''
    lefthook install
  '';
}
