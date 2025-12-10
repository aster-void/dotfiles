{...}: {
  imports = [
    ./claude-code
    ./direnv.nix
    ./gh.nix
    ./git.nix
    ./helix
    ./shells/bash.nix
    ./shells/fish.nix
    ./shells/nu.nix
    ./ssh.nix
    ./starship.nix
    ./zellij.nix
    ./zoxide.nix
  ];
}
