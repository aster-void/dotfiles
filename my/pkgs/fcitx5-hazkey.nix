{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  fcitx5,
  vulkan-loader,
  ...
}:
stdenv.mkDerivation rec {
  pname = "fcitx5-hazkey";
  version = "0.0.9";

  src = fetchurl {
    url = "https://github.com/7ka-Hiira/fcitx5-hazkey/releases/download/${version}/fcitx5-hazkey-${version}-x86_64.tar.gz";
    hash = "sha256-WPJDxp5iHEVjsiMt9NhvxVQShYYRPa51gDwA0dG2H3I=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    fcitx5
    vulkan-loader
    stdenv.cc.cc.lib
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out

    # Source root is 'usr', so paths below are relative to it

    # Copy the fcitx5 plugin to the standard location
    if [ -d lib/x86_64-linux-gnu/fcitx5 ]; then
      mkdir -p $out/lib/fcitx5
      cp lib/x86_64-linux-gnu/fcitx5/* $out/lib/fcitx5/
    fi

    # Copy the shared library to the standard location
    if [ -f lib/x86_64-linux-gnu/libhazkey.so ]; then
      mkdir -p $out/lib
      cp lib/x86_64-linux-gnu/libhazkey.so $out/lib/
    fi

    # Copy configuration and data files
    if [ -d share ]; then
      mkdir -p $out/share
      cp -r share/* $out/share/
    fi

    runHook postInstall
  '';

  postFixup = ''
    # Patch the shared library to find its dependencies
    if [ -f $out/lib/libhazkey.so ]; then
      patchelf --set-rpath "${lib.makeLibraryPath buildInputs}" $out/lib/libhazkey.so
    fi

    # Patch the fcitx5 plugin to find its dependencies
    if [ -f $out/lib/fcitx5/fcitx5-hazkey.so ]; then
      patchelf --set-rpath "${lib.makeLibraryPath buildInputs}:$out/lib" $out/lib/fcitx5/fcitx5-hazkey.so
    fi
  '';

  meta = with lib; {
    homepage = "https://github.com/7ka-Hiira/fcitx5-hazkey";
    description = "Japanese input method for fcitx5, powered by azooKey engine";
    license = licenses.mit;
    maintainers = [];
    platforms = ["x86_64-linux"];
    # No main program - this is a fcitx5 plugin
  };
}
