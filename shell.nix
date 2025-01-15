{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  name = "dotfile";
  buildInputs = with pkgs; [
    lefthook
    alejandra
    deadnix
    statix

    nwg-look
  ];
  shellHook = ''
    lefthook install
  '';
}
