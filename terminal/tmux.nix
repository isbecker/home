{ config, pkgs, ... }:
# let 
#  aw-watcher-tmux = pkgs.tmuxPlugins.mkTmuxPlugin {
#   pluginName = "aw-watcher-tmux";
#   version = "1.0";
#   src = pkgs.fetchFromGitHub {
#     owner = "akohlbecker";
#     repo = "aw-watcher-tmux";
#     rev = "efaa7610add52bd2b39cd98d0e8e082b1e126487";
#     sha256 = "sha256-L6YLyEOmb+vdz6bJdB0m5gONPpBp2fV3i9PiLSNrZNM=";
#   };
#  };
# in 
{
  programs.tmux = {
    enable = true;
    prefix = "C-a";
    mouse = true;
    newSession = true;
    keyMode = "vi";
    shell = "${pkgs.fish}/bin/fish";
    historyLimit = 100000;
    extraConfig = ''
      set-option -g renumber-windows on
      set-option -g status-interval 1
      set-option -g set-titles on
      set-option -g set-titles-string '#T'
      set-option -g automatic-rename on
      set-option -g automatic-rename-format '#{b:pane_current_path}'

      bind r source-file ${config.xdg.configHome}/tmux/tmux.conf
    '';
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.yank;
      }
      {
        plugin = tmuxPlugins.tmux-fzf;
      }
      {
        plugin = tmuxPlugins.cpu;
      }
      {
        plugin = tmuxPlugins.battery;
      }
      {
        plugin = tmuxPlugins.pass;
        extraConfig = ''
          set -g @pass-copy-to-clipboard on
          set -g @pass-window-size 50
        '';
      }
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-vim 'session'
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-capture-pane-contents 'on'
        '';
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-boot 'on'
          set -g @continuum-save-interval '10'
        '';
      }
      {
        plugin = tmuxPlugins.catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavour 'macchiato' # or frappe, macchiato, mocha, latte
          set -g @catppuccin_window_status_style "rounded"
          # Make the status line pretty and add some modules
          set -g status-right-length 100
          set -g status-left-length 100
          set -g status-left ""
          set -g status-right "#{E:@catppuccin_status_application}"
          set -agF status-right "#{E:@catppuccin_status_cpu}"
          set -ag status-right "#{E:@catppuccin_status_session}"
          set -ag status-right "#{E:@catppuccin_status_uptime}"
          set -agF status-right "#{E:@catppuccin_status_battery}"
        '';
      }
    ];
  };
}
