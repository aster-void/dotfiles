{
  pkgs,
  ...
}:
{
  services.hazkey.enable = false;

  i18n.inputMethod = {
    enable = false;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      kdePackages.fcitx5-qt
    ];
    fcitx5.waylandFrontend = true;
  };

  # Wait for wayland socket before starting fcitx5 to avoid "Failed to open wayland connection"
  systemd.user.services.fcitx5-daemon.Service = {
    ExecStartPre = "${pkgs.bash}/bin/bash -c 'for i in $(seq 1 50); do [ -S \"$XDG_RUNTIME_DIR/wayland-0\" ] && exit 0; sleep 0.1; done; exit 1'";
    Restart = "on-failure";
    RestartSec = 1;
  };

}
