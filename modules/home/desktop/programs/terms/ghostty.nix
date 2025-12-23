{pkgs, ...}: let
  # Workaround for GTK4 crash on monitor hotplug (scale=0 assertion failure)
  # https://github.com/ghostty-org/ghostty/discussions/3885
  ghostty-x11 = pkgs.symlinkJoin {
    name = "ghostty-x11";
    paths = [pkgs.ghostty];
    nativeBuildInputs = [pkgs.makeBinaryWrapper];
    postBuild = ''
      wrapProgram $out/bin/ghostty \
        --set GDK_BACKEND x11
    '';
  };
in {
  programs.ghostty = {
    enable = true;
    package = ghostty-x11;
    enableFishIntegration = true;
    settings = {
      theme = "Catppuccin Frappe";
      font-family = [
        "MesloLGM Nerd Font"
        "Noto Sans Mono CJK JP"
      ];
      font-size = 14;
      confirm-close-surface = false;
      mouse-scroll-multiplier = 3;
      cursor-style = "block";
      gtk-titlebar = false;
      linux-cgroup = "always";
      linux-cgroup-hard-fail = true;
      resize-overlay = "never";
    };
  };
}
