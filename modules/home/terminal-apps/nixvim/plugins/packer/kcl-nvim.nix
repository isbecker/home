{
  programs.nixvim = {
    plugins.packer = {
      plugins = [
        "kcl-lang/kcl.nvim"
      ];
    };
  };
}
