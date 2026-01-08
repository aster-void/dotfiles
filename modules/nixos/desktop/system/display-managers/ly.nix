{...}: {
  services.displayManager = {
    ly.enable = true;
    autoLogin.enable = false; # LY doesn't support auto login
  };
}
