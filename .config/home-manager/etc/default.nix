{ ... }: {
  imports = [
    # ./ime.nix # it's installed system wide so
    ./cursor.nix
    ./gtk.nix
    ./services.nix
  ];
}
