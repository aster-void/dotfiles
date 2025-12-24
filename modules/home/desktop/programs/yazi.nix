{pkgs, ...}: {
  programs.yazi = {
    enable = true;
    package = pkgs.yazi;
    enableFishIntegration = true;
    settings = {
      preview = {
        image_filter = "nearest";
        max_width = 600;
        max_height = 600;
      };

      tasks = {
        image_bound = [65535 65535];
      };
    };
  };
}
