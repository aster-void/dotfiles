{ pkgs, ... }: {
  home.packages = with pkgs; [
    vscode
  ];
  nixos-wsl-vscode = {
    enable = true;
  };
}
