{
  programs.nixvim = {
    plugins.barbar = {
      enable = true;
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>tn";
        action = "<cmd>BufferNext<CR>";
        options = {
          silent = true;
          desc = "Next Buffer (Tab)";
        };
      }
      {
        mode = "n";
        key = "<leader>tp";
        action = "<cmd>BufferPrevious<CR>";
        options = {
          silent = true;
          desc = "Previous Buffer (Tab)";
        };
      }
      {
        mode = "n";
        key = "<leader>tq";
        action = "<cmd>BufferClose<CR>";
        options = {
          silent = true;
          desc = "Close Buffer (Tab)";
        };
      }
      {
        mode = "n";
        key = "<leader>tf";
        action = "<cmd>BufferPick<CR>";
        options = {
          silent = true;
          desc = "Pick Buffer (Tab)";
        };
      }
      {
        mode = "n";
        key = "<leader>tP";
        action = "<cmd>BufferPin<CR>";
        options = {
          silent = true;
          desc = "Pin Buffer (Tab)";
        };
      }
      {
        mode = "n";
        key = "<leader>tu";
        action = "<cmd>BufferRestore<CR>";
        options = {
          silent = true;
          desc = "Undo Close Buffer (Tab)";
        };
      }
      {
        mode = "n";
        key = "<leader>tgg";
        action = "<cmd>BufferMoveStart<CR>";
        options = {
          silent = true;
          desc = "Move Buffer Start (Tab)";
        };
      }
    ];
  };
}
