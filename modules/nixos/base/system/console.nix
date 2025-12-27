{pkgs, ...}: {
  boot.kernelParams = ["consoleblank=300"];

  # Use kmscon instead of standard console for full Unicode/CJK support
  services.kmscon = {
    enable = true;
    hwRender = true;
    useXkbConfig = true;
    fonts = [
      {
        name = "Sarasa Term J";
        package = pkgs.sarasa-gothic;
      }
    ];
    extraConfig = "font-size=14";
  };
}
