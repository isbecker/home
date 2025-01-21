{
  programs.nixvim = {
    plugins.toggleterm = {
      enable = true;
      settings = {
        direction = "float";
        float_opts = {
          border = "curved";
          height = 60;
          width = 300;
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
