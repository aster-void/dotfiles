{inputs, ...}: {
  imports = [inputs.webhooker.nixosModules.webhooker];

  services.webhooker = {
    enable = true;
    port = 8085;
  };
}
