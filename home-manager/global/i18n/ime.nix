{pkgs, ...}: let
  fcitx5-addons = with pkgs; [
    fcitx5-mozc
    fcitx5-mozc-ut
    my.fcitx5-hazkey
  ];
in {
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = fcitx5-addons;
  };
  home.sessionVariables = {
    XMODIFIERS = "@im=fcitx";
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    INPUT_METHOD = "fcitx";
  };
}
