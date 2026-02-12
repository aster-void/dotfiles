{pkgs, ...}: {
  services.printing = {
    enable = true;
    drivers = [pkgs.mfcj880dwcupswrapper pkgs.mfcj880dwlpr];
  };
  programs.system-config-printer.enable = true;
}
