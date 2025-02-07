{
  programs.nixvim = {
    plugins.persistence = {
      enable = false;
      settings = {
        branch = false;
        need = 0;
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>qs";
        action = "<cmd>lua require('persistence').load()<CR>";
        #    lua = true;
        options = {
          silent = true;
          desc = "Load Session";
        };
      }
      {
        mode = "n";
        key = "<leader>qS";
        action = "<cmd>lua require('persistence').select()<CR>";
        #    lua = true;
        options = {
          silent = true;
          desc = "Select Session";
        };
      }
      {
        mode = "n";
        key = "<leader>ql";
        action = "<cmd>lua require('persistence').load({last = true})<CR>";
        #    lua = true;
        options = {
          silent = true;
          desc = "Load last Session";
        };
      }
    ];
  };
}
