{ pkgs }: pkgs.writeShellApplication {
  name = "reload";
  runtimeInputs = [ pkgs.killall ];

  text = ''
    case $1 in
      "waybar")
        killall -SIGUSR2 -r waybar
        exit 0;;
      *)
        echo "Unknown program: got $1"
        exit 1;;
    esac
  '';
}
