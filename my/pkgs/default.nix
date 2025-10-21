{pkgs, ...}: rec {
  waydroid-ui = pkgs.callPackage ./waydroid-ui.nix {};
  setpaper = pkgs.callPackage ./setpaper {};
  wpick = pkgs.callPackage ./wpick.nix {
    inherit setpaper;
    wallCommand = ''
      setpaper --wall "$path";
    '';
    lockCommand = ''
      setpaper --lock "$path"
    '';
  };
  hyprshade = pkgs.callPackage ./hyprshade.nix {
    inherit (pkgs.python312Packages) buildPythonPackage hatchling more-itertools click;
  };

  fcitx5-hazkey = pkgs.callPackage ./fcitx5-hazkey.nix {};
}
