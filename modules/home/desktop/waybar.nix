{ flake, config, pkgs, lib, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
  accent = config.catppuccin.accent;
in
{
  catppuccin.waybar.enable = true;
  catppuccin.waybar.flavor = config.catppuccin.flavor;
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "bottom";
        height = 30;

        modules-left = [
          "sway/workspaces"
          "sway/mode"
          "sway/window"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "pulseaudio"
          "pulseaudio/slider"
          "cpu"
          "memory"
          "network"
          # "wlr/taskbar"
          "tray"
        ];
        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = "󰝟 muted";
          format-icons = {
            default = [ "󰕿" "󰖀" "󰕾" ];
          };
          tooltip = false;
        };
      };
    };
    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: IosevkaTerm;
      }
      window#waybar {
        background: @base;
        color: @text;
      }
      #workspaces {
        background: @mantle;
        padding: 2px 6px;
      }
      #workspaces button {
        padding: 0 8px;
        margin: 2px 4px;
        border-radius: 8px;

        /* the request: workspace numbers use the accent color */
        color: @${accent};

        background: transparent;
        transition: all 120ms ease;
      }
      #workspaces button:hover {
        background: @surface0;
        color: @${accent};
      }
      #workspaces button.focused,
      #workspaces button.active {
        background: @${accent};
        color: @crust;
      }

      /* Urgent workspace: red pill */
      #workspaces button.urgent {
        background: @red;
        color: @crust;
      }

      /* Mode: loud but coherent */
      #mode {
        background: @mauve;
        color: @crust;
        font-weight: 700;
      }

      /* Window title: subtle */
      #window {
        background: @surface0;
        color: @text;
        margin: 6px 6px;
        padding: 4px 12px;
        border-radius: 12px;

        font-weight: 600;

        /* keep it from taking over the whole bar */
        min-width: 0;

      }
      #window.empty {
        background: @mantle;
        color: @overlay1;
      }

      #clock {
        padding: 4px 14px;
        margin: 6px 6px;
        border-radius: 14px;
      
        background: @sapphire;
        color: @crust;
        font-weight: 700;
      }

      #cpu,
      #memory,
      #network,
      #tray {
        padding: 4px 12px;
        margin: 6px 6px;
        border-radius: 12px;
      }
      #cpu {
        background: @peach;
        color: @crust;
        font-weight: 600;
      }

      #memory {
        background: @teal;
        color: @crust;
        font-weight: 600;
      }
      #network {
        background: @blue;
        color: @crust;
        font-weight: 600;
      }

      /* if you use waybar's built-in state classes */
      #network.disconnected {
        background: @red;
        color: @crust;
      }

      #network.linked,
      #network.wifi,
      #network.ethernet {
        background: @blue;
        color: @crust;
      }
      #taskbar {
        background: @surface0;
        color: @text;
        padding: 2px 6px;
      }

      /* Taskbar buttons */
      #taskbar button {
        padding: 0 8px;
        margin: 2px 4px;
        border-radius: 8px;
        background: transparent;
        color: @text;
        transition: all 120ms ease;
      }

      #taskbar button:hover {
        background: @surface1;
      }

      /* focused app in taskbar: lavender pill */
      #taskbar button.active,
      #taskbar button.focused {
        background: @lavender;
        color: @crust;
      }

      /* Optional: tray if you add it later */
      #tray {
        background: @surface0;
        color: @text;
      }

      /* Tooltips */
      tooltip {
        background: @crust;
        border-radius: 10px;
        padding: 8px;
      }

      tooltip label {
        color: @text;
      }
      /* Pulseaudio slider container */
      #pulseaudio-slider {
        margin: 6px 6px;
        padding: 4px 12px;
        border-radius: 12px;

        background: @surface0;
      }

      /* Hide the actual GTK slider knob */
      #pulseaudio-slider slider {
        min-height: 0px;
        min-width: 0px;
        opacity: 0;
        background-image: none;
        border: none;
        box-shadow: none;
      }

      /* The track */
      #pulseaudio-slider trough {
        min-height: 10px;
        min-width: 90px;
        border-radius: 999px;

        background: @crust;
      }

      /* The filled portion */
      #pulseaudio-slider highlight {
        min-width: 10px;
        border-radius: 999px;

        background: @mauve;
      }
      #pulseaudio.muted + #pulseaudio-slider highlight {
        background: @overlay0;
      }
      #pulseaudio {
        margin: 6px 0 6px 6px;
        padding: 4px 10px;
        border-radius: 12px;

        background: @surface0;
        color: @text;
        font-weight: 600;
      }

      #pulseaudio.muted {
        background: @surface0;
        color: @overlay1;
      }
    '';

  };
}
