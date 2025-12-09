{pkgs, ...}: {
  programs.alacritty = {
    enable = true;
    package = pkgs.alacritty;
    theme = "catppuccin_frappe";
    settings = {
      terminal.shell = "fish";
      scrolling.multiplier = 10;
      window.decorations = "None";
      font = {
        normal.family = "MesloLGMNerdFont";
        size = 16;
      };
    };
  };
}
