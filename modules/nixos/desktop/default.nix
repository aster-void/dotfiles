# Desktop environment module (Hyprland-based)
{
  inputs,
  flake,
  ...
}: {
  imports =
    [
      inputs.nix-flatpak.nixosModules.nix-flatpak
      inputs.lanzaboote.nixosModules.lanzaboote
      ./options.nix
      ./packages.nix
    ]
    ++ flake.lib.collectFiles ./extensions
    ++ flake.lib.collectFiles ./hardware
    ++ flake.lib.collectFiles ./services
    ++ flake.lib.collectFiles ./system;
}
