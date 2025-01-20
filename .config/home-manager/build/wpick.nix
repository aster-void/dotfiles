{pkgs}:
pkgs.writeShellApplication {
  name = "wpick";
  runtimeInputs = with pkgs; [yazi]; # I can probably assume xargs exists in the env
  text = ''
    yazi --chooser-file=/dev/stdout | xargs setpaper
  '';
}
