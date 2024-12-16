{ ... }: {
  imports = [
    ./plugins/wsl-vscode.nix
    ./plugins/waybar/config.nix
  ];
  packages = {
    core.enable = true;
    desktop.enable = true;
    self-hosted.enable = true;
  };
}
