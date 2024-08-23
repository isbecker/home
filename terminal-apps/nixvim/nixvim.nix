{ flake, pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
    colorschemes = {
      catppuccin = {
        enable = true;
        settings = {
          flavour = "macchiato";
          integrations = {
            cmp = true;
            gitsigns = true;
            mini = {
              enabled = true;
              indentscope_color = "";
            };
            notify = false;
            nvimtree = true;
            treesitter = true;
          };
        };
      };
    };
    clipboard = {
      providers.xsel.enable = true;
    };

    plugins = {
      direnv.enable = true;
      neo-tree = {
        enable = true;
        enableGitStatus = true;
        enableModifiedMarkers = true;
        enableRefreshOnWrite = true;
      };
      indent-o-matic.enable = true;
    };

    keymaps = [
      {
        mode = [ "n" ];
        key = "<leader>e";
        action = "<cmd>Neotree toggle<cr>";
        options = { desc = "Open/Close Neotree"; };
      }
    ];
  };
}
