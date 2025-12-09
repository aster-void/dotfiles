{pkgs, ...}: {
  programs.yazi = {
    enable = true;
    package = pkgs.yazi;
    enableFishIntegration = true;
    settings = {
      tasks = {
        image_bound = [65535 65535];
      };
    };
  };
}
