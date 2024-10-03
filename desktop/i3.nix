{ pkgs, lib, config, ... }:
{
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;

    config = rec {
      modifier = "Mod4";
      fonts = {
        names = [ "Iosevka Nerd Font" ];
        style = "Bold Semi-Condensed";
        size = 11.0;
      };
      bars = [ ];
      gaps = {
        inner = 10;
        outer = 5;
        # smartBorders = "on";
        # smartGaps = "on";
      };
      menu = "rofi -show combi";
      workspaceAutoBackAndForth = true;
      floating = {
        criteria = [
          {
            title = "Volume Control";
          }
          {
            class = "Pavucontrol";
          }
        ];
      };
      assigns = {
        "1: mail" = [
          {
            class = "^Firefox$";
            title = "^Mail.* - Outlook";
            # output = "primary";
          }
        ];
        "2: web" = [
          { class = "^Firefox$"; }
        ];
        "3: term" = [
          { class = "^kitty$"; }
        ];
        "4: slack" = [
          {
            class = "^Slack$";
            # output = "primary";
          }
        ];
        "8: zoom" = [
          {
            class = "^zoom$";
            # output = "primary";
          }
        ];
      };
      keybindings = lib.mkOptionDefault {
        "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "XF86AudioMicMute" = "exec pactl set-source-volume @DEFAULT_SOURCE@ toggle";
        "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
        "XF86MonBrightnessUp" = "exec brightnessctl set 5%+";

        "${modifier}+Return" = "exec kitty";
        "${modifier}+space" = "exec rofi -show combi";
        "${modifier}+Ctrl+space" = "exec ${config.xdg.configHome}/gigarandr/gigarandr.py";
        "${modifier}+Ctrl+Shift+space" = "move workspace to output next";
        "${modifier}+Ctrl+Shift+Mod1+space" = "workspace back_and_forth";
        "${modifier}+Tab" = "workspace back_and_forth";

        "${modifier}+Ctrl+Shift+Mod1+space+p" = "exec i3-resurrect save -w1";

        "${modifier}+Shift+c" = "reload";
        "${modifier}+Shift+r" = "restart";

        "Print" = "exec flameshot gui";

        "Ctrl+Shift+l" = "exec systemctl suspend";
      };
      startup = [
        {
          command = "feh --bg-scale ${config.home.homeDirectory}/Pictures/wallpaper.jpg";
          always = true;
          notification = false;
        }
      ];
    };
  };
}
