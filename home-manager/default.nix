{
  inputs,
  pkgs,
  build,
  extraSpecialArgs,
}: let
  inherit (inputs) home-manager;
  inherit (pkgs) system;

  preprocess = {
    enable-pkgs,
    extra-modules ? [],
  }:
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs extraSpecialArgs;
      modules =
        [
          ./home.nix
          (import ./template/packages.nix {
            inherit enable-pkgs;
          })
        ]
        ++ extra-modules;
    };
  standard-wsl-packages = [
    "cli"
    "editor"
    [
      pkgs.helix
      inputs.claude-monitor.packages.${system}.default
    ]
  ];
  standard-desktop-packages = [
    "cli"
    "desktop"
    "editor"
    "large"
    [
      pkgs.helix
      inputs.claude-monitor.packages.${system}.default

      # inputs.helix.packages.${system}.default
      inputs.zen-browser.packages.${system}.beta
      # build.line # I give up. install it via steam.
      build.setpaper
      build.wpick
    ]
  ];
in {
  amberwood = preprocess {
    enable-pkgs = standard-desktop-packages;
    extra-modules = [
      ./modules/minecraft
    ];
  };
  amberwood-wsl = preprocess {
    enable-pkgs = standard-wsl-packages;
  };
  bogster = preprocess {
    enable-pkgs = standard-desktop-packages;
    extra-modules = [
      ./modules/minecraft
    ];
  };
  carbon = preprocess {
    enable-pkgs = standard-desktop-packages;
  };
  carbon-wsl = preprocess {
    enable-pkgs = standard-wsl-packages;
  };
}
