{ ... }: {
  imports = [
    # ./ime.nix # it's installed system wide so
    ./cursor.nix
    ./cursor-env.nix
    ./gtk.nix
    ./services.nix
  ];
}
