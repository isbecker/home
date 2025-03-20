{
  programs.nixvim = {
    plugins.noice = {
      enable = true;
      settings = {
        presets.inc_rename = true;
      };
    };
  };
}
