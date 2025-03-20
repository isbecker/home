{
  programs.nixvim = {
    plugins.neo-tree = {
      enable = true;
      enableGitStatus = true;
      enableModifiedMarkers = true;
      enableRefreshOnWrite = true;
      buffers = {
        followCurrentFile = {
          enabled = true;
          leaveDirsOpen = false;
        };
      };
      filesystem = {
        bindToCwd = true;
        useLibuvFileWatcher = true;
        followCurrentFile = {
          enabled = true;
          leaveDirsOpen = false;
        };
      };
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
