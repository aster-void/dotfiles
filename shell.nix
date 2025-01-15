{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  name = "dotfile";
  buildInputs = with pkgs; [
    lefthook
    nixpkgs-fmt
    deadnix

    nwg-look
  ];
  shellHook = ''
    lefthook install
  '';
}
