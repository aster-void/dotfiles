{inputs, ...}: {
  imports = [
    ./users.nix
    ./env.nix
    ./docker.nix
  ];

  nixpkgs.overlays = [inputs.edgepkgs.overlays.default];

  # Enable nix-ld for running unpatched binaries
  programs.nix-ld.enable = true;
}
