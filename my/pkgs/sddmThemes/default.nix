{
  inputs,
  pkgs,
}: {
  sddm-astronaut-theme = pkgs.callPackage ./sddm-astronaut-theme.nix {inherit inputs;};
}
