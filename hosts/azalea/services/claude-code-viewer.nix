{flake, ...}: {
  imports = [flake.inputs.nix-repository.nixosModules.claude-code-viewer];

  services.claude-code-viewer = {
    enable = true;
    user = "aster";
    host = "localhost";
    port = 7002;
  };
}
