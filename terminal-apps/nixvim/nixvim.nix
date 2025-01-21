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
    globals = {
      mapleader = ",";
    };
    extraConfigVim = ''
      set autoread
    '';
    opts = {
      number = true;
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
    ];
  };
}
