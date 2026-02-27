{
  pkgs,
  inputs,
  ...
}:
{
  services.hazkey = {
    enable = true;
    server.package =
      inputs.nix-hazkey.packages.${pkgs.stdenv.hostPlatform.system}.hazkey-server.override
        {
          enableVulkan = true;
        };
  };

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      kdePackages.fcitx5-qt
    ];
    fcitx5.waylandFrontend = true;
  };

}
