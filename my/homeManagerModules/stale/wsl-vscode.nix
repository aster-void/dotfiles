{pkgs, ...}: {
  config.home.file.".vscode-server/server-env-setup".source = "${pkgs.fetchFromGitHub {
    owner = "sonowz";
    repo = "vscode-remote-wsl-nixos";
    rev = "55ba0a5969763fecfa10d194a8ab76caa42774cf";
    hash = "sha256-m18X5GZPrKKNyNDg4Xy4wjd076gMA+sb+pLuMzFGDPE=";
  }}/server-env-setup";
}
