{
  programs.nixvim = {
    plugins.auto-save = {
      enable = true;
      settings = {
        enabled = true;
        debounce_delay = 1000;
        write_all_buffers = true;
        lockmarks = true;
        condition = ''
          function(buf)
            return true
          end
        '';
      };
    };
  };
}
