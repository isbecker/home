{
  programs.nixvim = {
    plugins.zen-mode = {
      enable = true;
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>za";
        action = "<cmd>lua require('zen-mode').toggle({window = {width = .85}})<CR>";
        #    lua = true;
        options = {
          silent = true;
          desc = "Zen Mode";
        };
      }
    ];
  };
}

