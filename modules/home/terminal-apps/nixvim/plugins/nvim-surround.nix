{
  programs.nixvim = {
    plugins.nvim-surround = {
      enable = true;
      settings = {
        # keymaps = ''
        #   {
        #     insert = "<leader><C-g>s";
        #     insert_line = "<leader><C-g>S";
        #     normal = "<leader>ys";
        #     normal_cur = "<leader>ss";
        #     normal_line = "<leader>S";
        #     normal_cur_line = "<leader>SS";
        #     visual = "<leader>";
        #     visual_line = "<leader>S";
        #     delete = "<leader>s";
        #     change = "<leader>s";
        #     change_line = "<leader>S";
        #   }
        # '';
        keymaps = {
          insert = "<C-g>s";
          insert_line = "<C-g>S";
          normal = "ys";
          normal_cur = "yss";
          normal_line = "yS";
          normal_cur_line = "ySS";
          visual = "S";
          visual_line = "gS";
          delete = "ds";
          change = "cs";
          change_line = "cS";
        };

      };
    };
  };
}
