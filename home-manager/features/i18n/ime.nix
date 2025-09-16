{pkgs, ...}: let
  fcitx5-addons = with pkgs; [
    fcitx5-mozc
    fcitx5-mozc-ut
    mozcdic-ut-jawiki
    mozcdic-ut-sudachidict
  ];
in {
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = fcitx5-addons;
  };
  home.sessionVariables = {
    XMODIFIERS = "@im=fcitx";
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    INPUT_METHOD = "fcitx";
  };

  systemd.user.startServices = "sd-switch";
  systemd.user.services.fcitx5 = {
    Unit = {
      Description = "Fcitx5 input method";
      PartOf = ["graphical-session.target"];
      After = ["graphical-session.target"];
    };
    Service = {
      Type = "dbus";
      BusName = "org.fcitx.Fcitx5";
      ExecStart = "${pkgs.bash}/bin/bash -c fcitx5";
      Restart = "on-failure";
      RestartSec = 1;
    };
    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };
}
