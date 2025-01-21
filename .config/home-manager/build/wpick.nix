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
      l|lock)
        setpaper --lock "$path"
      ;;
      a|all)
        setpaper --wall --lock "$path"
      ;;
      *)
        setpaper --wall "$path"
      ;;
    esac
  '';
}
