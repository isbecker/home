{ config, pkgs, ... }:
{
  programs.ghostty = {
    enable = true;
    #package = (config.lib.nixGL.wrap pkgs.ghostty);
    enableFishIntegration = true;
    settings = {
      theme = "catppuccin-mocha";
      font-family = "IosevkaTerm Nerd Font Mono";
      font-size = 10;

      window-decoration = "false";
    };
  };
  home.sessionVariables = {
    GHOSTTY_RESOURCES_DIR = "${pkgs.ghostty}/share/ghostty";
  };
}
