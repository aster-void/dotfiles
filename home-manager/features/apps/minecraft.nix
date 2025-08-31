{pkgs, ...}: {
  home.packages = [
    pkgs.prismlauncher
    pkgs.temurin-bin-24
  ];
}
