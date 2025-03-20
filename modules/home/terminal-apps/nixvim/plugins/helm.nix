{
  programs.nixvim = {
    plugins.helm = {
      enable = true;
    };
    autoCmd = [
      {
        event = "FileType";
        pattern = "helm";
        command = "LspRestart";
      }
    ];
  };
}

