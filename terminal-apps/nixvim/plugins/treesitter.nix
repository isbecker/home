{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.treesitter = {
      enable = true;
      # languageRegister = { make = [ "justfile" ]; };
      # grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      #   bash
      #   json
      #   just
      #   lua
      #   make
      #   markdown
      #   nix
      #   regex
      #   toml
      #   vim
      #   vimdoc
      #   xml
      #   yaml
      # ];


    };
    plugins.treesitter-context.enable = true;
    plugins.treesitter-refactor.enable = true;
    plugins.treesitter-textobjects.enable = true;
  };
}

