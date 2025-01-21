{pkgs}:
pkgs.writeShellApplication {
  name = "wpick";
  runtimeInputs = [
    pkgs.yazi
    (pkgs.callPackage ./setpaper {})
  ]; # I can probably assume xargs exists in the env
  text = ''
    path=$(yazi --chooser-file=/dev/stdout)
    case $1 in
      h|help|-h|--help)
        echo "
          usage:
            wpick # pick your wallpaper
            wpick lock # pick your lock screen
            wpick all # choose both your wallpaper and wall
            wpick help # show this help
        ";
      ;;
      l|lock)
        setpaper --lock "$path"
      ;;
      a|all)
        setpaper --wall --lock "$path"
      ;;
      -*)
        echo "wpick: Unknown flag: $1"
        exit 1
      ;;
      *)
        setpaper --wall "$path"
      ;;
    esac
  '';
}
