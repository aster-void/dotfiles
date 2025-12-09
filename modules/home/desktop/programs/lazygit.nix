{pkgs, ...}: {
  programs.lazygit = {
    enable = true;
    package = pkgs.lazygit;
    settings = {
      git = {
        pull = {
          mode = "rebase";
        };
      };
    };
  };
}
