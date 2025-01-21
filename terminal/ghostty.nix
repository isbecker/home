{ config, pkgs, ... }:
{
  programs.ghostty = {
    enable = true;
    package = (config.lib.nixGL.wrap pkgs.ghostty);
    enableFishIntegration = true;
    settings = {
      theme = "catppuccin-mocha";
      font-family = "IosevkaTerm Nerd Font Mono";
      font-size = 10;

      background-opacity = "0.9";
      window-decoration = "false";
    };
  };
}
