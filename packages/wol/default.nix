{pkgs, ...}:
pkgs.writeShellApplication {
  name = "wol";
  runtimeInputs = [pkgs.openssh];
  text = builtins.readFile ./main.sh;
}
