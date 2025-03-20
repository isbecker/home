{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.lastplace = {
      enable = true;
      # package = pkgs.vimPlugins.vim-lastplace;
    };
  };
}

