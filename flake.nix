{
  description = "NixOS + Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    comin.url = "github:nlewo/comin";
    comin.inputs.nixpkgs.follows = "nixpkgs";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";

    playit-nixos-module.url = "github:pedorich-n/playit-nixos-module";
    playit-nixos-module.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-repository.url = "github:aster-void/nix-repository";

    # Desktop inputs (from dotfiles)
    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    lanzaboote.url = "github:nix-community/lanzaboote/v1.0.0";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";
    lanzaboote.inputs.rust-overlay.follows = "rust-overlay";

    caelestia-shell.url = "github:caelestia-dots/shell";
    caelestia-shell.inputs.nixpkgs.follows = "nixpkgs";

    caelestia-cli.url = "github:caelestia-dots/cli";
    caelestia-cli.inputs.nixpkgs.follows = "nixpkgs";

    mcp-servers-nix.url = "github:natsukium/mcp-servers-nix";
    mcp-servers-nix.inputs.nixpkgs.follows = "nixpkgs";

    llm-agents.url = "github:numtide/llm-agents.nix";
    llm-agents.inputs.nixpkgs.follows = "nixpkgs";

    nix-hazkey.url = "github:aster-void/nix-hazkey";
    nix-hazkey.inputs.nixpkgs.follows = "nixpkgs";

    claude-desktop.url = "github:k3d3/claude-desktop-linux-flake";
    claude-desktop.inputs.nixpkgs.follows = "nixpkgs";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.inputs.home-manager.follows = "home-manager";

    webhooker.url = "github:aster-void/webhooker";
    webhooker.inputs.nixpkgs.follows = "nixpkgs";

    nvf.url = "github:notashelf/nvf";
    nvf.inputs.nixpkgs.follows = "nixpkgs";

    # determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    mkNixosSystem = hostname:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
          flake = self;
        };
        modules = [./nixos/hosts/${hostname}];
      };

    mkHome = {
      hostname,
      username,
    }:
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit inputs;
          flake = self;
        };
        modules = [
          ./home-manager/hosts/${hostname}/${username}.nix
          {
            home.username = username;
            home.homeDirectory = "/home/${username}";
            nixpkgs.config.allowUnfree = true;
          }
        ];
      };
  in {
    lib = import ./lib {inherit (nixpkgs) lib;};

    nixosConfigurations = {
      azalea = mkNixosSystem "azalea";
      bluebell = mkNixosSystem "bluebell";
      daisy = mkNixosSystem "daisy";
    };

    homeConfigurations = {
      "aster@azalea" = mkHome {
        hostname = "azalea";
        username = "aster";
      };
      "aster@bluebell" = mkHome {
        hostname = "bluebell";
        username = "aster";
      };
      "aster@daisy" = mkHome {
        hostname = "daisy";
        username = "aster";
      };
    };

    packages.${system} = {
      fhs = pkgs.callPackage ./packages/fhs {};
      setpaper = pkgs.callPackage ./packages/setpaper {};
      waydroid-ui = pkgs.callPackage ./packages/waydroid-ui {};
      wol = pkgs.callPackage ./packages/wol {};
      wpick = pkgs.callPackage ./packages/wpick {};
    };
  };

  nixConfig = {
    extra-substituters = [
      "https://playit-nixos-module.cachix.org"
      "https://nix-repository--aster-void.cachix.org"
      "https://helix.cachix.org"
      "https://devenv.cachix.org"
      "https://nix-community.cachix.org"
      # "https://install.determinate.systems"
    ];
    extra-trusted-public-keys = [
      "playit-nixos-module.cachix.org-1:22hBXWXBbd/7o1cOnh+p0hpFUVk9lPdRLX3p5YSfRz4="
      "nix-repository--aster-void.cachix.org-1:A+IaiSvtaGcenevi21IvvODJoO61MtVbLFApMDXQ1Zs="
      "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.flakehub.com-3:hJuILl5sVK4iKm86JzgdXW12Y2Hwd5G07qKtHTOcDCM="
      "cache.flakehub.com-4:Asi8qIv291s0aYLyH6IOnr5Kf6+OF14WVjkE6t3xMio="
      "cache.flakehub.com-5:zB96CRlL7tiPtzA9/WKyPkp3A2vqxqgdgyTVNGShPDU="
      "cache.flakehub.com-6:W4EGFwAGgBj3he7c5fNh9NkOXw0PUVaxygCVKeuvaqU="
      "cache.flakehub.com-7:mvxJ2DZVHn/kRxlIaxYNMuDG1OvMckZu32um1TadOR8="
      "cache.flakehub.com-8:moO+OVS0mnTjBTcOUh2kYLQEd59ExzyoW1QgQ8XAARQ="
      "cache.flakehub.com-9:wChaSeTI6TeCuV/Sg2513ZIM9i0qJaYsF+lZCXg0J6o="
      "cache.flakehub.com-10:2GqeNlIp6AKp4EF2MVbE1kBOp9iBSyo0UPR9KoR0o1Y="
    ];
  };
}
