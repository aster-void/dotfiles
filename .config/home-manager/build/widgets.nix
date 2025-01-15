{pkgs}:
pkgs.writeShellApplication {
  name = "widgets";
  runtimeInputs = with pkgs; [eww libnotify];

  text = ''
    case $1 in
      "home")
        notify-send "opening home widget (todo)"
        exit 0;;
      *)
        echo "Unknown widget: got $1"
        exit 1;;
    esac
  '';
}
