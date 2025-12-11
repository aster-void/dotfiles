{
  inputs,
  pkgs,
  lib,
  ...
}: let
  inherit (pkgs.stdenv) system;
  nix-repository = inputs.nix-repository.packages.${system};
in {
  imports = [
    ./languages.nix
  ];

  programs.helix = {
    enable = true;
    package = nix-repository.helix-gj1118;
    defaultEditor = false;
    settings = lib.mkMerge [
      # Base configuration
      {
        theme = "catppuccin_mocha";
        editor = {
          auto-format = true;
          line-number = "relative";
          end-of-line-diagnostics = "hint";
          inline-diagnostics = {
            cursor-line = "error";
          };
          cursor-shape = {
            insert = "bar";
            normal = "block";
          };
          mouse = true;
          soft-wrap = {
            enable = true;
          };
          true-color = true;
          rulers = [80 100];
          indent-guides = {
            render = true;
            character = "▏";
            skip-levels = 2;
          };
          file-picker = {
            hidden = false;
          };
          whitespace = {
            characters = {
              space = " ";
              nbsp = "⍽";
              nnbsp = "␣";
              tab = "→";
            };
          };
        };
        keys = {
          insert = {
            C-c = ["completion"];
          };
        };
      }

      # helix-gj1118 specific features
      {
        editor = {
          # Rounded corners for UI elements
          rounded-corners = true;

          # Custom ruler character
          ruler-char = "┊";

          # Popup-style command line
          cmdline = {
            style = "popup";
            show-icons = true;
            min-popup-width = 40;
            max-popup-width = 80;
            use-full-height = true;
            icons = {
              search = "🔍";
              command = "💫";
              shell = "⚡";
              general = "💬";
            };
          };

          # Color swatches for LSP
          lsp = {
            display-color-swatches = true;
            color-swatches-string = "●";
          };

          # Gradient borders
          gradient-borders = {
            enable = true;
            thickness = 2;
            direction = "horizontal";
            start-color = "#8A2BE2";
            end-color = "#00BFFF";
            animation-speed = 3;
          };
        };

        # helix-gj1118 keybindings
        keys = {
          normal = {
            space.K = "goto_hover"; # Open documentation in navigable buffer
          };
        };
      }
    ];
  };
}
