{inputs, ...}: {
  imports = [inputs.nvf.homeManagerModules.default];

  programs.nvf = {
    enable = true;
    settings.vim = {
      viAlias = true;
      vimAlias = true;

      luaConfigRC.closeFloatWithEsc = ''
        vim.api.nvim_create_autocmd("FileType", {
          callback = function()
            if vim.api.nvim_win_get_config(0).relative ~= "" then
              vim.keymap.set("n", "<Esc>", "<cmd>close<CR>", { buffer = true })
            end
          end,
        })
      '';

      lsp = {
        enable = true;
        formatOnSave = true;
      };

      treesitter = {
        enable = true;
        addDefaultGrammars = true;
      };

      assistant.supermaven-nvim = {
        enable = true;
        setupOpts.keymaps = {
          accept_suggestion = "<C-y>";
          clear_suggestion = "<C-]>";
          accept_word = "<C-j>";
        };
      };

      languages = {
        enableLSP = true;
        enableTreesitter = true;

        nix.enable = true;
        markdown.enable = true;
        html.enable = true;
        css.enable = true;
        ts.enable = true;
        svelte.enable = true;
        python.enable = true;
        rust.enable = true;
        go.enable = true;
        lua.enable = true;
        bash.enable = true;
        clang.enable = true;
        haskell.enable = true;
        ocaml.enable = true;
        elixir.enable = true;
        typst.enable = true;
      };

      theme = {
        enable = true;
        name = "catppuccin";
        style = "mocha";
      };

      statusline.lualine.enable = true;
      telescope.enable = true;
      autocomplete.nvim-cmp.enable = true;

      visuals = {
        nvimWebDevicons.enable = true;
        indentBlankline.enable = true;
      };

      git.gitsigns.enable = true;

      keymaps = [
        {
          key = "ge";
          mode = ["n" "v"];
          action = "G";
          desc = "Go to end of file";
        }
      ];
    };
  };
}
