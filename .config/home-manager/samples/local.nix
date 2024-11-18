{ pkgs, ... }: {
  home.packages = with pkgs; [
    vscode
  ];
  nixos-wsl-vscode = {
    enable = true;
  };
  packages = {
    core.enable = true;
    desktop.enable = true;
    self-hosted.enable = true;
  };
  # nixvim.enable = true;
}
