{pkgs, ...}: {
  v-analyzer = pkgs.callPackage ./v-analyzer {};
  waydroid-ui = pkgs.callPackage ./waydroid-ui.nix {};
  reload = pkgs.callPackage ./reload.nix {};
  reload-d = pkgs.callPackage ./reload-d.nix {};
}
