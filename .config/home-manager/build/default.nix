{
  python312Packages,
  callPackage,
  ...
}: {
  v-analyzer = callPackage ./v-analyzer {};
  waydroid-ui = callPackage ./waydroid-ui.nix {};
  reload = callPackage ./reload.nix {};
  reload-d = callPackage ./reload-d.nix {};
  setpaper = callPackage ./setpaper {};
  wpick = callPackage ./wpick.nix {};
  hyprshade = callPackage ./hyprshade.nix {
    inherit (python312Packages) buildPythonPackage hatchling more-itertools click;
  };
}
