{
  inputs,
  python312Packages,
  callPackage,
  ...
}: rec {
  v-analyzer = callPackage ./v-analyzer {};
  waydroid-ui = callPackage ./waydroid-ui.nix {};
  setpaper = callPackage ./setpaper {};
  wpick = callPackage ./wpick.nix {
    inherit setpaper;
    wallCommand = ''
      setpaper --wall "$path";
    '';
    lockCommand = ''
      setpaper --lock "$path"
    '';
  };
  hyprshade = callPackage ./hyprshade.nix {
    inherit (python312Packages) buildPythonPackage hatchling more-itertools click;
  };

  sddmThemes = callPackage ./sddmThemes {inherit inputs;};
  nerd-fonts = callPackage ./nerd-fonts {inherit inputs;};
}
