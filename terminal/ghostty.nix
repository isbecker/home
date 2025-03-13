{ config, pkgs, ... }:
{
  programs.ghostty = {
    enable = true;
    package = (config.lib.nixGL.wrappers.nvidia pkgs.ghostty);
    enableFishIntegration = true;
    settings = {
      theme = "catppuccin-mocha";
      font-family = "IosevkaTerm Nerd Font Mono";
      font-size = 10;

      window-decoration = "false";
      window-vsync = "false";
      keybind = [
        "global:super+escape=toggle_quick_terminal"
      ];
      custom-shader = "${config.xdg.dataHome}/ghostty/crt.glsl";
      # custom-shader = "${config.xdg.dataHome}/ghostty/bloom.glsl";
      custom-shader-animation = true;
    };
  };
  home.sessionVariables = {
    GHOSTTY_RESOURCES_DIR = "${pkgs.ghostty}/share/ghostty";
  };
}
