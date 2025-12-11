{...}: {
  programs.zellij = {
    enable = true;
    settings = {
      copy_on_select = false;
      session_serialization = false;
      show_startup_tips = false;
    };
  };
}
