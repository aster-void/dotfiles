{
  security.polkit.enable = true;

  # Enable ClamAV.
  services.clamav = {
    daemon.enable = false;

    scanner.enable = false;
    updater.enable = false;

    # third-party virus definition files? https://rseichter.github.io/fangfrisch/
    fangfrisch.enable = false;
  };
}
