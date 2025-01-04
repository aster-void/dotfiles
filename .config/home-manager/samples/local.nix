{ ... }: {
  imports = [
    ./plugins/wsl-vscode.nix
  ];
  packages = {
    core.enable = true;
    desktop.enable = true;
    self-hosted.enable = true;
  };
}
