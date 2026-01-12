{
  programs.nixvim = {
    
    plugins.neo-tree = {
      enable = true;

      settings = {
        enable_git_status = true;
        enable_modified_markers = true;
        enable_refresh_on_write = true;

        buffers = {
          follow_current_file = {
            enabled = true;
            leave_dirs_open = false;
          };
        };

        filesystem = {
          bind_to_cwd = true;
          use_libuv_file_watcher = true;
          follow_current_file = {
            enabled = true;
            leave_dirs_open = false;
          };
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
