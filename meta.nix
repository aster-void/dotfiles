{
  username = "aster";
  # TODO: make system flexible (e.g. make this flake also usable in darwin)
  system = "x86_64-linux";

  git = {
    user = "aster";
    email = "137767097+aster-void@users.noreply.github.com";
  };

  home = {
    dotfilesDir = ".dotfiles"; # path to the dotfiles from $HOME (gets appended after ${home.homeDir}/)
  };
  publicKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILRFghJcSqpsjAF3VVwTYdNF6yU73pNjMpDfNPtMh9ju"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINWhvqrrKaaFFcE6LGfVujgFGStteGcBRhuPMJ5mNdLq"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHIUFCw/2UFXtaF5R7qOKhFMrAi6W9GSpbJ1EKNYuA58"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIldntqQ74sdKhP8yi/nFY9PM+tLDbfuWIOr2Ym4NeFh"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFNKEKYKhdlRZ+gMam304oIAxGEYTefHUYwboqjcW99P"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILjmP4kY/yvrkPHWkI4e4IVOKVjMv88N0VHDsySBouSO"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILVrQDjz7yJR6ydu7/j9OwNMDS9EM8Ke9ityA89SpDai"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKHMh59cO6u8ri6CLjR5qiShc+feKIi7bIY7UOYBiM1r root@carbon"
  ];
}
