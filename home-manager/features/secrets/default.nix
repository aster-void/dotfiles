{
  inputs,
  config,
  ...
}: let
  inherit (config.age) secrets;
in {
  imports = [
    inputs.agenix.homeManagerModules.age
  ];

  age.secrets.github-public-access-token.file = ../../../secrets/github/public-access-token.age;

  programs.fish.shellInit = ''
    export GITHUB_TOKEN=$(cat ${builtins.replaceStrings ["{" "}"] ["" ""] secrets.github-public-access-token.path});
  '';
}
