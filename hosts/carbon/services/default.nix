{...}: {
  imports = [
    ./claude-code-viewer.nix
    ./cloudflared.nix
    ./docker.nix
    ./dokploy.nix
    ./llama-cpp.nix
    ./minecraft.nix
    ./syncthing.nix
  ];
}
