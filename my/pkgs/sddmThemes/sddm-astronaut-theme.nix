{
  inputs,
  stdenv,
  ...
}: let
  # Custom sddm-astronaut theme from flake input
  sddm-astronaut-git = stdenv.mkDerivation {
    pname = "sddm-astronaut-theme";
    version = "git";

    src = inputs.sddm-astronaut-theme;

    installPhase = ''
      mkdir -p $out/share/sddm/themes/sddm-astronaut-theme
      cp -r * $out/share/sddm/themes/sddm-astronaut-theme/
    '';
  };
in
  sddm-astronaut-git
