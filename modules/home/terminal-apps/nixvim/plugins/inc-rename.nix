{
  programs.nixvim = {
    plugins.inc-rename = {
      enable = true;
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>rn";
        action.__raw = ''
          function()
            return ":IncRename " .. vim.fn.expand("<cword>")
          end
        '';
        options = {
          desc = "Incremental Rename";
        };
      }
    ];
  };
}
