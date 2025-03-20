{
  programs.nixvim = {
    plugins.schemastore = {
      enable = true;
      yaml.enable = true;
      json.enable = true;
    };
  };
}
