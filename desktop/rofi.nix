{ flake, pkgs, ... }:
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
      catppuccin.enable = true;
      # font = "Iosevka Nerd Font 14";

      pass = {
        enable = true;
      };

      theme."*".font = "Iosevka Nerd Font 14";

      extraConfig = {
        modi = "window,run,drun,emoji";
        # combi-modi = "run,drun,window,emoji";
        cycle = true;
        case-sensitive = false;
        icon-theme = "Oranchelo";
        show-icons = true;
        display-drun = " 󰣆  Apps ";
        display-run = "   Run ";
        display-window = "    Window ";
        sidebar-mode = true;
      };
    };
}