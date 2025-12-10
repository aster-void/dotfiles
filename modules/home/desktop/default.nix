{inputs, ...}: {
  imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
    inputs.nix-hazkey.homeModules.hazkey

    ./options.nix
    ./env.nix
    ./packages.nix
    ./xdg.nix
    ./system
    ./programs
    ./services
    ./extensions
  ];
}
