{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = [pkgs.cachix];
  age.secrets.nix-conf = {
    file = ../../../../secrets/nix.conf.age;
    mode = "400";
  };

  nix.channel.enable = false;
  nix.extraOptions = ''
    !include ${config.age.secrets.nix-conf.path}
  '';
  nix.settings = {
    trusted-users = ["root" "@wheel"];

    # 並列ビルド
    max-jobs = "auto";
    cores = 0;

    # キャッシュ効率化
    keep-outputs = true;
    keep-derivations = true;
    auto-optimise-store = true;

    substituters = [
      "https://playit-nixos-module.cachix.org"
      "https://nix-repository--aster-void.cachix.org"
      "https://devenv.cachix.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "playit-nixos-module.cachix.org-1:22hBXWXBbd/7o1cOnh+p0hpFUVk9lPdRLX3p5YSfRz4="
      "nix-repository--aster-void.cachix.org-1:A+IaiSvtaGcenevi21IvvODJoO61MtVbLFApMDXQ1Zs="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
}
