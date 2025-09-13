{
  imports = [
    ./bootloader
    ./system
    ./users
    ./network
    ./i18n
    ./hardware
    ./assertions.nix
    ./nix.nix
    ./services.nix
    # ./secrets.nix  # 一時的に無効化
  ];
}
