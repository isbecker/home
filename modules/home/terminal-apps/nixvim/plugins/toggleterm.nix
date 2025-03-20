{
  programs.nixvim = {
    plugins.toggleterm = {
      enable = true;
      settings = {
        direction = "float";
        float_opts = {
          border = "curved";
          height = 40;
          width = 260;
        };
        open_mapping = "[[<c->]]";
      };

    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>tt";
        action = "<cmd>lua require('toggleterm').toggle()<CR>";
        #    lua = true;
        options = {
          silent = true;
          desc = "ToggleTerm Show";
        };
      }

    ];
  };
}
