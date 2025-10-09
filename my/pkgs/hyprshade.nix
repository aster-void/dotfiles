{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  hatchling,
  more-itertools,
  click,
  hyprland,
  makeWrapper,
}:
buildPythonPackage {
  pname = "hyprshade";
  version = "latest";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "loqusion";
    repo = "hyprshade";
    rev = "152cd2ea06d9412d62bc628d62ee5af7771190b1"; # latest commit at 2025-02-07, from 2024-07-28
    hash = "sha256-MlbNE9n//Qb6OJc3DMkOpnPtoodfV8JlG/I5rOfWMtQ=";
  };

  nativeBuildInputs = [
    hatchling
    makeWrapper
  ];

  propagatedBuildInputs = [
    more-itertools
    click
  ];

  postFixup = ''
    wrapProgram $out/bin/hyprshade \
      --set HYPRSHADE_SHADERS_DIR $out/share/hyprshade/shaders \
      --prefix PATH : ${lib.makeBinPath [hyprland]}
  '';

  meta = with lib; {
    homepage = "https://github.com/loqusion/hyprshade";
    description = "Hyprland shade configuration tool";
    mainProgram = "hyprshade";
    license = licenses.mit;
    maintainers = with maintainers; [willswats];
    platforms = platforms.linux;
  };
}
