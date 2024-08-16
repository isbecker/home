{ flake, pkgs, lib, config, ... }:
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
        {
          command = "systemctl --user restart polybar.service";
          always = true;
          notification = false;
        }
        {
          command = "systemctl --user restart barrierc.service";
          always = true;
          notification = false;
        }
        {
          command = "systemctl --user restart fusuma.service";
          always = true;
          notification = false;
        }
        {
          command = "systemctl --user restart activitywatch-watcher-aw-watcher-afk.service";
          always = true;
          notification = false;
        }
        {
          command = "systemctl --user restart activitywatch-watcher-aw-watcher-window.service";
          always = true;
          notification = false;
        }
        {
          command = "systemctl --user restart dunst.service";
          always = true;
          notification = false;
        }
      ];
    };
  };
}
