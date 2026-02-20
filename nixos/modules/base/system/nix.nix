{
  config,
  flake,
  pkgs,
  ...
}: {
  environment.systemPackages = [pkgs.cachix];
  age.secrets.nix-conf = {
    file = "${flake}/secrets/nix.conf.age";
    mode = "400";
  };

  nix.channel.enable = false;
  nix.extraOptions = ''
    !include ${config.age.secrets.nix-conf.path}
  '';
  # CPU使用率を70%に制限（ビルド中もシステムを使えるように）
  systemd.services.nix-daemon.serviceConfig.CPUQuota = "70%";

  nix.settings = {
    accept-flake-config = true;
    trusted-users = ["root" "@wheel"];

    # 並列ビルド
    max-jobs = "auto";
    cores = 0;

    # キャッシュ効率化
    keep-outputs = true;
    keep-derivations = true;
    auto-optimise-store = true;
  };
}
