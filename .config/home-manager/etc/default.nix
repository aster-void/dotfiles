{ ... }: {
  imports = [
    # ./ime.nix # it's installed system wide so
    ./cursor.nix
    # ./cursor-env.nix
    ./services.nix
  ];
}
