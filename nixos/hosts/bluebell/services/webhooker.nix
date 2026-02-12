{inputs, ...}: {
  imports = [inputs.webhooker.nixosModules.webhooker];

  services.webhooker = {
    enable = true;
    port = 8085;
    domain = "https://webhook.aster-void.dev";
  };
}
