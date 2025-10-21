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

  fcitx5-hazkey = pkgs.callPackage ./fcitx5-hazkey.nix {};
}
