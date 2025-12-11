{inputs, ...}: {
  imports = [
    ./docker.nix
    ./env.nix
    ./users.nix
  ];

  nixpkgs.overlays = [inputs.edgepkgs.overlays.default];

  # Enable nix-ld for running unpatched binaries
  programs.nix-ld.enable = true;
}
