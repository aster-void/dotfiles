{
  inputs,
  callPackage,
}: {
  sddm-astronaut-theme = callPackage ./sddm-astronaut-theme.nix {inherit inputs;};
}
