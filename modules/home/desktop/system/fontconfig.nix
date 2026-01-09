{osConfig, ...}: let
  fontconfigPath = osConfig.environment.etc.fonts.source;
in {
  # Custom fonts.conf for Flatpak apps
  # Uses NixOS fontconfig directly from nix store (no host-etc needed)
  xdg.configFile."fontconfig/flatpak-fonts.conf".text = ''
    <?xml version="1.0"?>
    <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
    <fontconfig>
      <include>${fontconfigPath}/fonts.conf</include>
      <include>${fontconfigPath}/conf.d</include>
      <dir>/run/host/fonts</dir>
      <dir>/run/host/local-fonts</dir>
      <dir>/run/host/user-fonts</dir>
    </fontconfig>
  '';
}
