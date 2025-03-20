{
  programs.nixvim = {
    plugins.treesitter = {
      enable = true;
      languageRegister = { make = [ "justfile" ]; };

    };
    plugins.treesitter-context.enable = true;
    plugins.treesitter-refactor.enable = true;
    plugins.treesitter-textobjects.enable = true;
  };
}

