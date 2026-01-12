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
          "cpu"
          "memory"
          "network"
          # "wlr/taskbar"
          "tray"
        ];
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
    '';

  };
}
