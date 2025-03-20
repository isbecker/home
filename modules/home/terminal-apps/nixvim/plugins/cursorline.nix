{
  programs.nixvim = {
    plugins.cursorline = {
      enable = true;
      settings = {
        cursorline.enable = true;
        cursorword.enable = true;
      };
    };
  };
}

