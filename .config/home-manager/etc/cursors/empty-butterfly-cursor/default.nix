{ lib
, stdenvNoCC
, unzip
, ...
}:
let
  archive = {
    butter = ./Empty-Butterfly-Butter-vr7-Linux.zip;
    cyan = ./Empty-Butterfly-Cyan-vr7-Linux.zip;
    green = ./Empty-Butterfly-Green-vr7-Linux.zip;
    magenta = ./Empty-Butterfly-Magenta-vr7-Linux.zip;
    orange = ./Empty-Butterfly-Orange-vr7-Linux.zip;
    purple = ./Empty-Butterfly-Purple-vr7-Linux.zip;
    red = ./Empty-Butterfly-Red-vr7-Linux.zip;
    white = ./Empty-Butterfly-White-vr7-Linux.zip;
    yellow = ./Empty-Butterfly-Yellow-vr7-Linux.zip;
  };
in
lib.attrsets.mapAttrs
  (
    name: path:
    stdenvNoCC.mkDerivation {
      name = "Empty-Butterfly-${name}";
      src = ./.;
      nativeBuildInputs = [ unzip ];
      patchPhase = ''
        if [ -e tmp ]; then rm -r tmp; fi
        mkdir tmp;
        cd tmp;
        cp ${path} .
      '';
      buildPhase = ''
        mkdir -p $out/share/icons
        unzip ./$(basename ${path})
        mv $(basename ${path})/$(basename ${path}) $out/share/icons
      '';
    }
  )
  archive
