{
  programs.nixvim = {
    enable = true;
    colorschemes = {
      catppuccin = {
        enable = true;
        settings = {
          flavour = "macchiato";
          integrations = {
            cmp = true;
            gitsigns = true;
            mini = {
              enabled = true;
              indentscope_color = "";
            };
            notify = false;
            neo-tree.nvim = true;
            treesitter = true;
            telescope = true;
            dashboard = true;
            diffview = true;
            barbar = true;
          };
        };
      };
    };
    clipboard = {
      register = "unnamedplus";
      providers.xsel.enable = true;
    };

    plugins = {
      direnv.enable = true;
      neo-tree = {
        enable = true;
        enableGitStatus = true;
        enableModifiedMarkers = true;
        enableRefreshOnWrite = true;
      };
      mini = {
        enable = true;
        mockDevIcons = true;
        modules = {
          icons = {
            style = "glyph";
          };
        };
      };
      barbar.enable = true;
      flash = {
        enable = true;
        settings = {
          labels = "asdfghjklqwertyuiopzxcvbnm";
        };
      };
      # leap = {
      #   enable = true;
      #   labels = [
      #     "s"
      #     "f"
      #     "n"
      #     "j"
      #     "k"
      #     "l"
      #     "h"
      #     "o"
      #     "d"
      #     "w"
      #     "e"
      #     "m"
      #     "b"
      #     "u"
      #     "y"
      #     "v"
      #     "r"
      #     "g"
      #     "t"
      #     "c"
      #     "x"
      #     "/"
      #     "z"
      #     "S"
      #     "F"
      #     "N"
      #     "J"
      #     "K"
      #     "L"
      #     "H"
      #     "O"
      #     "D"
      #     "W"
      #     "E"
      #     "M"
      #     "B"
      #     "U"
      #     "Y"
      #     "V"
      #     "R"
      #     "G"
      #     "T"
      #     "C"
      #     "X"
      #     "?"
      #     "Z"
      #   ];
      #   safeLabels = [
      #     "s"
      #     "f"
      #     "n"
      #     "u"
      #     "t"
      #     "/"
      #     "S"
      #     "F"
      #     "N"
      #     "L"
      #     "H"
      #     "M"
      #     "U"
      #     "G"
      #     "T"
      #     "?"
      #     "Z"
      #   ];
      # };
      lualine = {
        enable = true;
        settings = {
          options = {
            globalstatus = true;
          };
          sections = {
            lualine_a = [ "mode" ];
            lualine_b = [ "branch" ];
            lualine_c = [ "filename" "diff" ];
          };
        };
      };
      # lightline = {
      # enable = true;
      # settings = {
      #   colorscheme = "catppuccin";
      # };
      # };
      fugitive.enable = true;
      lsp = {
        enable = true;
        servers = {
          yamlls.enable = true;
          jsonls.enable = true;
          nil_ls.enable = true;
          taplo.enable = true;
          # ts_ls.enable = true;
          ruff.enable = true;
          helm_ls.enable = true;
          dockerls.enable = true;
          ansiblels.enable = true;
          terraformls.enable = true;
          html.enable = true;
        };
      };
      indent-o-matic.enable = true;
      gitblame.enable = true;
      gitgutter.enable = true;
      gitlinker.enable = true;
      comment.enable = true;
      dashboard.enable = true;
      git-conflict.enable = true;
      treesitter.enable = true;
      schemastore = {
        enable = true;
        yaml.enable = true;
        json.enable = true;
      };
    };

    keymaps = [
      {
        mode = [ "n" ];
        key = "<leader>e";
        action = "<cmd>Neotree toggle<cr>";
        options = { desc = "Open/Close Neotree"; };
      }
      {
        mode = [ "n" "x" "o" ];
        key = "s";
        action = ''function() require("flash").jump() end'';
        options = { desc = "Flash"; };
      }
      {
        mode = [ "n" "o" "x" ];
        key = "S";
        action = ''function() require("flash").treesitter() end'';
        options = { desc = "Flash Treesitter"; };
      }
      {
        mode = [ "o" ];
        key = "r";
        action = ''function() require("flash").remote() end'';
        options = { desc = "Remote Flash"; };
      }
      {
        mode = [ "o" "x" ];
        key = "R";
        action = ''function() require("flash").treesitter_search() end'';
        options = { desc = "Treesitter Search"; };
      }
      {
        mode = [ "c" ];
        key = "<c-s>";
        action = ''function() require("flash").toggle() end'';
        options = { desc = "Toggle Flash Search"; };
      }
    ];
  };
}
