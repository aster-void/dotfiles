{pkgs, ...}: {
  # Operational tools required for GitOps management
  environment.systemPackages = with pkgs; [
    git # Required for GitOps operations
    helix # Required for system administration
    wakeonlan
  ];

  # Git configuration for operations
  programs.git = {
    enable = true;
    config = {
      pull.rebase = true;
      user.name = "aster";
      user.email = "137767097+aster-void@users.noreply.github.com";
    };
  };
}
