{
  pkgs,
  config,
  ...
}: let
  inherit (builtins) elem;
  inherit (pkgs) fcitx5;
  inherit (config.environment) systemPackages;
in {
  assertions = [
    {
      assertion = !(elem fcitx5 systemPackages);
      message = "fcitx5 must not be installed via environment.systemPackages,
as it does not contain addons and may (will) make it impossible to find the addon.
use i18n.inputMethod and only it.";
    }
  ];
}
