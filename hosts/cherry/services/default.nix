{...}: {
  imports = [
    ./cloudflared.nix
    ./docker.nix
    ./llama-cpp.nix
    ./minecraft.nix
    ./syncthing.nix
  ];
}
