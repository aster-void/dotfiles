{inputs, ...}: {
  imports = [
    inputs.nix-dokploy.nixosModules.default
  ];

  services.dokploy = {
    enable = true;
    port = "7000:3000";

    # Use private IP (default - recommended for security)
    swarm.advertiseAddress = "private";
    swarm.autoRecreate = true;
  };
}
