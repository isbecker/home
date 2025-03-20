{ config, pkgs, ... }:
{
  programs.rofi = {
    package = pkgs.rofi.override {
      plugins = [
        pkgs.rofi-emoji
        pkgs.rofi-pass
        pkgs.rofi-power-menu
      ];
    };
    enable = true;
    font = "Iosevka NFM 16";

    pass = {
      enable = true;
      stores = [
        "${config.xdg.dataHome}/password-store"
      ];
    };

    # theme."*".font = "Iosevka NFM Regular 16";

    extraConfig = {
      modi = "window,run,drun,emoji,combi";
      # combi-modi = "run,drun,window,emoji";
      cycle = true;
      case-sensitive = false;
      icon-theme = "Oranchelo";
      show-icons = true;
      display-drun = "🖊 App";
      display-run = "🚀 Run";
      display-window = "🪟 Win";
      display-emoji = "😀 Emo";
      sidebar-mode = true;
    };
  };
}
