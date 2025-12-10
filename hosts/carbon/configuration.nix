{flake, ...}: {
  imports = [
    flake.nixosModules.base
    flake.nixosModules.profile-dev
    flake.inputs.nix-repository.nixosModules.claude-code-viewer
    ./hardware-configuration.nix
    ./system
    ./services
  ];
}
