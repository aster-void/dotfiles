{config, ...}: let
  localBin = "${config.home.homeDirectory}/.local/bin";
in {
  imports = [
    ./bash.nix
    ./fish.nix
    ./nu.nix
  ];

  programs.bash.initExtra = ''
    export PATH="${localBin}:$PATH"
  '';
  programs.fish.interactiveShellInit = ''
    fish_add_path --prepend ${localBin}
  '';
  programs.nushell.extraEnv = ''
    $env.PATH = ($env.PATH | prepend "${localBin}")
  '';
}
