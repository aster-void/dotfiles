{flake, ...}: {
  imports = [flake.inputs.nix-repository.nixosModules.claude-code-viewer];

  services.claude-code-viewer = {
    enable = false;
    user = "aster";
    host = "localhost";
    port = 7002;
  };
}
