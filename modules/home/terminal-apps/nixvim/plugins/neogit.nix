{
  programs.nixvim = {
    plugins.neogit = {
      enable = true;
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>gg";
        action = "<cmd>Neogit cwd=%:p:h<cr>";
        options = {
          silent = true;
          desc = "󰊢 Neogit";
        };
      }
      {
        mode = "n";
        key = "<leader>gf";
        action = "<cmd>Neogit cwd=%:p:h kind=floating<cr>";
        options = {
          silent = true;
          desc = "󰊢 Neogit floating";
        };
      }
    ];
  };
}
