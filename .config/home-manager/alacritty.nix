{pkgs, ...}: 
{
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = {
          family = "DejaVu";
          style = "Regular";
        };
        size = 11;
      };
    };
  colors = let theme = "ashes_light"; in import ./alacritty-themes/${theme}.nix
  };
}
