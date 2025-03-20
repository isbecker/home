{
  programs.nixvim = {
    plugins.firenvim = {
      enable = true;
      luaConfig.post =
        ''
          vim.fn["firenvim#install"](0)
        '';
    };
    extraConfigLua = ''
      if vim.g.started_by_firenvim == true then
      	vim.o.laststatus = 0
        -- other stuff
      end
    '';
  };
}



