{
  programs.nixvim = {
    enable = true;
    colorschemes = {
      catppuccin = {
        enable = true;
        settings = {
          transparent_background = true;
          flavour = "macchiato";
          integrations = {
            cmp = true;
            gitsigns = true;
            mini = {
              enabled = true;
              indentscope_color = "";
            };
            notify = true;
            neo-tree.nvim = true;
            treesitter = true;
            telescope = true;
            dashboard = true;
            diffview = true;
            barbar = true;
            indent_blankline = {
              enabled = true;
              colored_indent_levels = true;
            };
          };
        };
      };
    };
    globals = {
      mapleader = ",";
    };
    opts = {
      number = true;
      relativenumber = true;
      sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions";
    };
    clipboard = {
      register = "unnamedplus";
      providers.xsel.enable = true;
    };
  };
}

