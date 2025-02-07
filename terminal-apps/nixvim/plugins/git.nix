{
  programs.nixvim = {
    plugins = {
      fugitive.enable = true;
      gitblame.enable = true;
      gitgutter.enable = true;
      gitlinker.enable = true;
      git-conflict.enable = true;
    };
  };
}
