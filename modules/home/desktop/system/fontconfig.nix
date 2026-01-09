{
  # Custom fonts.conf for Flatpak apps
  # Uses host fontconfig via /run/host/etc/static (NixOS)
  xdg.configFile."fontconfig/flatpak-fonts.conf".text = ''
    <?xml version="1.0"?>
    <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
    <fontconfig>
      <include>/run/host/etc/static/fonts/fonts.conf</include>
      <include>/run/host/etc/static/fonts/conf.d</include>
      <dir>/run/host/fonts</dir>
      <dir>/run/host/local-fonts</dir>
      <dir>/run/host/user-fonts</dir>
    </fontconfig>
  '';
}
