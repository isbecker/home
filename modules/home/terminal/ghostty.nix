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
      window-vsync = "true";

      cursor-color = "b7bdf8"; # lavender
      cursor-text = "ed8796"; # red
      cursor-opacity = ".75";
      cursor-style = "block_hollow";
    };
  };
  home.sessionVariables = {
    GHOSTTY_RESOURCES_DIR = "${pkgs.ghostty}/share/ghostty";
  };
}
