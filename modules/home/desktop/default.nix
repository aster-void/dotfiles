{
  inputs,
  flake,
  ...
}: {
  imports =
    [
      inputs.nix-flatpak.homeManagerModules.nix-flatpak
      inputs.nix-hazkey.homeModules.hazkey
      ./options.nix
      ./env.nix
      ./packages.nix
      ./xdg.nix
    ]
    ++ flake.lib.collectFiles ./extensions
    ++ flake.lib.collectFiles ./programs
    ++ flake.lib.collectFiles ./services
    ++ flake.lib.collectFiles ./system;
}
