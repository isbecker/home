{ flake, pkgs, ... }:
{
  programs.nixvim = {
    plugins.telescope = {
      enable = true;
      # extensions.fzf-native.enable = true;
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>f";
        action = "???";
        #    lua = true;
        options = {
          silent = true;
          desc = "  Find";
        };
      }

      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>lua require('telescope.builtin').find_files()<CR>";
        #    lua = true;
        options = {
          silent = true;
          desc = "Find Files";
        };
      }

      {
        mode = "n";
        key = "<leader>fg";
        action = "<cmd>lua require('telescope.builtin').live_grep()<CR>";
        #    lua = true;
        options = {
          silent = true;
          desc = "Grep Files";
        };
      }

      {
        mode = "n";
        key = "<leader>fb";
        action = "<cmd>lua require('telescope.builtin').buffers()<CR>";
        #    lua = true;
        options = {
          silent = true;
          desc = "Find Buffer";
        };
      }

      {
        mode = "n";
        key = "<leader>fh";
        action = "<cmd>lua require('telescope.builtin').help_tags()<CR>";
        #    lua = true;
        options = {
          silent = true;
          desc = "Find Help";
        };
      }

      {
        mode = "n";
        key = "<leader>fd";
        action = "<cmd>lua require('telescope.builtin').diagnostics()<CR>";
        #    lua = true;
        options = {
          silent = true;
          desc = "Find Diagnostics";
        };
      }

      {
        mode = "n";
        key = "<leader>ft";
        action = "<cmd>lua require('telescope.builtin').treesitter()<CR>";
        #    lua = true;
        options = {
          silent = true;
          desc = "Find Treesitter";
        };
      }
    ];
  };
}
