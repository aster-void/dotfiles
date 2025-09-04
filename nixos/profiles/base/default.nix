{
  shared,
  pkgs,
  ...
}: {
  # Base system profile - minimal NixOS installation
  imports = [
    ./system.nix
    ./users.nix
    ./networking.nix
    ./locale.nix
    ./console.nix
    ./services.nix
  ];
}
