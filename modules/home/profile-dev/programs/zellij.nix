{...}: {
  programs.zellij = {
    enable = true;
    settings = {
      session_serialization = false;
      show_startup_tips = false;
    };
  };
}
