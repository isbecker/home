{
  programs.nixvim = {
    plugins.twilight = {
      enable = true;
      settings = {
        context = 20;
        dimming = {
          alpha = 0.35;
        };
        expand = [
          "function"
          "method"
          "table"
          "if_statement"
        ];
        treesitter = true;
      };
    };
  };
}
