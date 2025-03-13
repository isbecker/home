{
  programs.nixvim = {
    plugins.auto-session = {
      enable = true;
      settings = {
        previewer = true;
        bypass_save_filetypes = [ "alpha" "dashboard" ];
        cwd_change_handling = true;
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>wr";
        action = "<cmd>SessionSearch<CR>";
        #    lua = true;
        options = {
          silent = true;
          desc = "Session search";
        };
      }
      {
        mode = "n";
        key = "<leader>ws";
        action = "<cmd>SessionSave<CR>";
        #    lua = true;
        options = {
          silent = true;
          desc = "Save session";
        };
      }
      {
        mode = "n";
        key = "<leader>wa";
        action = "<cmd>SessionToggleAutoSave<CR>";
        #    lua = true;
        options = {
          silent = true;
          desc = "Toggle autosave";
        };
      }

    ];
  };
}
