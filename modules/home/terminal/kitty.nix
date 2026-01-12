{ config, pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    #package = (config.lib.nixGL.wrap pkgs.kitty);
    enableGitIntegration = true;
    shellIntegration.enableFishIntegration = true;
    # shellIntegration.enableNushellIntegration = true;
    font = {
      name = "IosevkaTerm Nerd Font Mono";
      size = 12;
    };
    themeFile = "Catppuccin-Macchiato";
    settings = {
      allow_remote_control = "yes";
    };
  };
}
