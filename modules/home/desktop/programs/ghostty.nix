{pkgs, ...}: {
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty;
    enableBashIntegration = true;
    settings = {
      theme = "xcodedarkhc";
      gtk-titlebar = false;
      mouse-scroll-multiplier = 2;
      linux-cgroup = "always";
      linux-cgroup-hard-fail = true;
      resize-overlay = "never";
    };
  };
}
