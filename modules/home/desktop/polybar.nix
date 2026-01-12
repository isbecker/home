{ config, pkgs, ... }:

let
  bar_name = "bottom";

  bg = "\${colors.base}";
  fg = "\${colors.surface0}";

  text = "\${colors.text}";
  subtext = "\${colors.subtext1}";

  surface = "\${colors.surface0}";

  # Colored
  primary = "\${colors.peach}";

  # Dark
  secondary = "\${colors.mantle}";

  # Colored (light)
  tertiary = "\${colors.green}";

  # white
  # quaternary = "\${colors.rosewater}";

  # middle gray
  quinternary = "\${colors.lavender}";

  # Red
  urgency = "\${colors.red}";

in
{
  services.polybar = {
    enable = false;
    package = pkgs.polybar.override {
      i3Support = true;
      pulseSupport = true;
    };
    config = {
      "bar/${bar_name}" = {
        font-0 = "IosevkaTerm Nerd Font Mono,IosevkaTerm NFM:size=10;2";
        background = bg;
        foreground = fg;
        border-color = "\${colors.crust}";
        border-size = "4pt";

        monitor = "\${env:MONITOR:DP-1}";

        width = "100%";
        height = "3.5%";

        bottom = "true";
        radius = 0;

        modules-left = "i3 title";
        modules-right = "wireless-network cpu memory audio battery tray";
        modules-center = "date";
      };
      "bar/${bar_name}-2" = {
        font-0 = "IosevkaTerm Nerd Font Mono,IosevkaTerm NFM:size=10;2";
        background = bg;
        foreground = fg;
        border-color = "\${colors.crust}";
        border-size = "4pt";

        monitor = "\${env:MONITOR:DP-2}";

        width = "100%";
        height = "3.5%";

        bottom = "true";
        radius = 0;

        modules-left = "i3 title";
        modules-right = "wireless-network cpu memory audio battery tray";
        modules-center = "date";
      };

      "module/i3" = {
        type = "internal/i3";
        pin-workspaces = "true";
        enable-click = "true";

        # format = "<label-state> <label-mode>";
        # format-background = "\${colors.mauve}";

        # label-mode = "%mode%";
        label-mode-padding = 1;

        # label-unfocused = "%index%";
        label-unfocused-foreground = subtext;
        label-unfocused-padding = 1;

        # label-focused = "%index%";
        label-focused-font = 2;
        label-focused-foreground = primary;
        label-focused-padding = 1;

        # label-visible = "%index%";
        label-visible-padding = 1;

        # label-urgent = "%index%";
        label-urgent-foreground = urgency;
        label-urgent-padding = 1;

        # label-separator = "";
      };

      "module/title" = {
        type = "internal/xwindow";

        format-background = "\${colors.blue}";
        format-foreground = text;
        format-padding = 1;

        label-maxlen = 72;
      };

      "module/date" = {
        type = "internal/date";
        internal = 5;
        date = "%m.%d.%y";
        time = "%H:%M";
        label = " %time%  %date%  ";

        format-foreground = text;
        format-padding = 1;
      };

      "module/audio" = {
        type = "internal/pulseaudio";

        format-volume = "VOL <label-volume>";
        format-volume-padding = 1;
        format-volume-foreground = secondary;
        format-volume-background = tertiary;
        label-volume = "%percentage%%";

        format-muted = "<label-muted>";
        format-muted-padding = 1;
        format-muted-foreground = secondary;
        format-muted-background = tertiary;
        format-muted-prefix = "M";
        format-muted-prefix-foreground = urgency;
        format-muted-overline = bg;

        label-muted = "VOL Muted";
      };

      "module/tray" = {
        type = "internal/tray";

        format = "<tray>";

        format-margin = "8px";
        tray-spacing = "8px";

        tray-background = bg;
        tray-foreground = quinternary;
      };

      "module/battery" = {
        type = "internal/battery";
        full-at = 101; # to disable it
        battery = "BAT0"; # TODO: Better way to fill this
        adapter = "AC0";

        poll-interval = 2;

        label-full = " 100%";
        format-full-padding = 1;
        format-full-foreground = secondary;
        format-full-background = quinternary;

        format-charging = " <animation-charging> <label-charging>";
        format-charging-padding = 1;
        format-charging-foreground = secondary;
        format-charging-background = quinternary;
        label-charging = "%percentage%% +%consumption%W";
        animation-charging-0 = "";
        animation-charging-1 = "";
        animation-charging-2 = "";
        animation-charging-3 = "";
        animation-charging-4 = "";
        animation-charging-framerate = 500;

        format-discharging = "<ramp-capacity> <label-discharging>";
        format-discharging-padding = 1;
        format-discharging-foreground = secondary;
        format-discharging-background = primary;
        label-discharging = "%percentage%% -%consumption%W";
        ramp-capacity-0 = "";
        ramp-capacity-0-foreground = urgency;
        ramp-capacity-1 = "";
        ramp-capacity-1-foreground = urgency;
        ramp-capacity-2 = "";
        ramp-capacity-3 = "";
        ramp-capacity-4 = "";
      };
      "module/wireless-network" = {
        type = "internal/network";
        interface = "wlp0s20f3";
        interface-type = "wireless";

        label-connected = "%essid% %netspeed:9%";
        label-connected-foreground = secondary;
        format-connected = "<ramp-signal> <label-connected>";
        format-connected-padding = 1;
        format-connected-background = "\${colors.flamingo}";

        label-disconnected = "not connected";
        label-disconnected-foreground = urgency;
        format-disconnected-padding = 1;
        format-disconnected-background = "\${colors.flamingo}";

        ramp-signal-0 = "󰤯";
        ramp-signal-1 = "󰤟";
        ramp-signal-2 = "󰤢";
        ramp-signal-3 = "󰤥";
        ramp-signal-4 = "󰤨";
        ramp-signal-5 = "󰤨";
      };

      "module/cpu" = {
        type = "internal/cpu";

        interval = "0.5";

        format = " <label>";
        format-foreground = secondary;
        format-background = "\${colors.teal}";
        format-padding = 1;

        label = "CPU %percentage%%";
      };
      "module/memory" = {
        type = "internal/memory";

        interval = "3";

        format = " <label>";
        format-foreground = secondary;
        format-background = "\${colors.yellow}";
        format-padding = 1;

        warn-percentage = "95";
      };
    };
    script = ''
      set -x
      /usr/bin/systemctl --user import-environment DISPLAY XAUTHORITY

      ${pkgs.xorg.xrandr}/bin/xrandr --screen 0 --query | ${pkgs.ripgrep}/bin/rg " connected"

      primary=$(${pkgs.xorg.xrandr}/bin/xrandr --screen 0 --query | ${pkgs.ripgrep}/bin/rg " connected" | ${pkgs.ripgrep}/bin/rg primary | ${pkgs.toybox}/bin/cut -d" " -f1)
      secondary=$(${pkgs.xorg.xrandr}/bin/xrandr --screen 0 --query | ${pkgs.ripgrep}/bin/rg " connected" | ${pkgs.ripgrep}/bin/rg -v primary | ${pkgs.toybox}/bin/cut -d" " -f1)
      
      echo "Primary: $primary"
      ${pkgs.toybox}/bin/env MONITOR=$primary polybar --reload ${bar_name} &

      if [ -n "$secondary" ]; then
        echo "Secondary: $secondary"
        ${pkgs.toybox}/bin/env MONITOR=$secondary polybar --reload ${bar_name}-2 &
      fi
    '';
  };

}
