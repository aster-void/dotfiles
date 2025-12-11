{
  inputs,
  flake,
  ...
}: {
  nixpkgs.overlays = [
    (_final: _prev: {inherit inputs;})
    (final: prev: {
      hyprshot = prev.callPackage ../../../overlays/hyprshot-fix/package.nix {
        hyprshot = prev.hyprshot;
      };
    })
  ];

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
