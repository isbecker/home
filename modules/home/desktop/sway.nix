{ pkgs, lib, config, flake, ... }:
{
  wayland.windowManager.sway = {
    enable = true;
    systemd.enable = true;
    swaynag.enable = true;
    wrapperFeatures.gtk = true;
    config = rec {
      modifier = "Mod4";
      terminal = "${lib.getExe pkgs.ghostty}";
      fonts = {
        names = [ "IosevkaTerm Nerd Font Mono" ];
        style = "Bold Semi-Condensed";
        size = 11.0;
      };
      bars = [ ];
      gaps = {
        inner = 10;
        outer = 5;
        smartBorders = "on";
        smartGaps = true;
      };
      menu = "rofi -show combi";
      workspaceAutoBackAndForth = true;
      floating = {
        criteria = [
          {
            title = "Steam - Update News";
          }
          {
            class = "Pavucontrol";
          }
        ];
      };
      assigns = {
        "2: web" = [
          { class = "^librewolf$"; }
        ];
        "3: term" = [
          { class = "^com.mitchellh.ghostty$"; }
        ];
        "4: msgs" = [
          {
            class = "^Signal$|^discord$";
            # output = "primary";
          }
        ];
      };
      keybindings = lib.mkOptionDefault {
        "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "XF86AudioMicMute" = "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle";
        "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
        "XF86MonBrightnessUp" = "exec brightnessctl set 5%+";

        "${modifier}+Return" = "exec ghostty";
        "${modifier}+space" = "exec rofi -show combi";
        # "${modifier}+Ctrl+space" = "exec ${lib.getExe' flake.inputs.gigarandr.packages.${pkgs.system}.default "gigarandr"} run";
        "${modifier}+Ctrl+Shift+space" = "move workspace to output next";
        "${modifier}+Ctrl+Shift+Mod1+space" = "workspace back_and_forth";
        "${modifier}+Tab" = "workspace back_and_forth";

        # "${modifier}+Ctrl+Shift+Mod1+space+p" = "exec i3-resurrect save -w1";

        "${modifier}+Shift+c" = "reload";
        "${modifier}+Shift+r" = "restart";

        "Print" = "exec flameshot gui";

        "Ctrl+Shift+l" = "exec systemctl suspend";
      };
      startup = [
        {
          command = "${lib.getExe config.services.swww.package} img ${config.home.homeDirectory}/Pictures/wallpaper.png";
          always = true;
          # notification = true;
        }
        # {
        #   command = "${lib.getExe pkgs.xorg.xrandr} --output DisplayPort-0 --mode 2560x1440 --rate 165.00 --primary --output DisplayPort-1 --mode 1920x1080 --rate 144.00 --right-of DisplayPort-0";
        #   always = true;
        # }
        {
          command = "${lib.getExe config.programs.ghostty.package}";
          # notification = true;
        }
        {
          command = "${lib.getExe config.programs.librewolf.package}";
          # notification = true;
        }
        {
          command = "${lib.getExe' pkgs.gnome-keyring "gnome-keyring-daemon"} --start --components=secrets";
          always = true;
          # notification = false;
        }
      ];
      colors = {
        background = "$base";
        focused = {
          background = "$base";
          border = "$lavender";
          childBorder = "$lavender";
          indicator = "$rosewater";
          text = "$text";
        };
        focusedInactive = {
          background = "$base";
          border = "$overlay0";
          childBorder = "$overlay0";
          indicator = "$rosewater";
          text = "$text";
        };
        unfocused = {
          background = "$base";
          border = "$overlay0";
          childBorder = "$overlay0";
          indicator = "$rosewater";
          text = "$text";
        };
        urgent = {
          background = "$base";
          border = "$peach";
          childBorder = "$peach";
          indicator = "$rosewater";
          text = "$text";
        };
        placeholder = {
          background = "$base";
          border = "$overlay0";
          childBorder = "$overlay0";
          indicator = "$overlay0";
          text = "$text";
        };
      };
    };
    extraConfig = ''
      set $rosewater #f4dbd6
      set $flamingo #f0c6c6
      set $pink #f5bde6
      set $mauve #c6a0f6
      set $red #ed8796
      set $maroon #ee99a0
      set $peach #f5a97f
      set $yellow #eed49f
      set $green #a6da95
      set $teal #8bd5ca
      set $sky #91d7e3
      set $sapphire #7dc4e4
      set $blue #8aadf4
      set $lavender #b7bdf8
      set $text #cad3f5
      set $subtext1 #b8c0e0
      set $subtext0 #a5adcb
      set $overlay2 #939ab7
      set $overlay1 #8087a2
      set $overlay0 #6e738d
      set $surface2 #5b6078
      set $surface1 #494d64
      set $surface0 #363a4f
      set $base #24273a
      set $mantle #1e2030
      set $crust #181926
    '';
  };
  # services.swaync.enable = true;
  services.mako.enable = true;
  services.swayosd.enable = true;
  services.swww.enable = true;
  services.wl-clip-persist.enable = true;
}
