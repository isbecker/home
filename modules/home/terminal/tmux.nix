{ config, pkgs, ... }:
{

  catppuccin = {
    tmux.extraConfig = ''
      set -g @catppuccin_window_status_style "rounded"

      # Make the status line pretty and add some modules
      set -g status-right-length 100
      set -g status-left-length 100
      set -g status-left ""
      set -g status-right "#{E:@catppuccin_status_application}"
      set -agF status-right "#{E:@catppuccin_status_cpu}"
      set -ag status-right "#{E:@catppuccin_status_session}"
    '';
  };
  programs.tmux = {
    enable = true;
    prefix = "C-a";
    mouse = true;
    newSession = true;
    keyMode = "vi";
    shell = "${pkgs.fish}/bin/fish";
    historyLimit = 100000;
    extraConfig = ''
      set-option -g base-index 1 
      set-option -gw pane-base-index 1
      set-option -g renumber-windows on
      set-option -g status-interval 1
      set-option -g set-titles on
      set-option -g set-titles-string '#T'
      set-option -g automatic-rename on

      bind r source-file ${config.xdg.configHome}/tmux/tmux.conf
      bind c new-window -c "#{pane_current_path}" 
      bind % split-window -h -c "#{pane_current_path}"
      bind '"' split-window -c "#{pane_current_path}"
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
        plugin = tmuxPlugins.extrakto;
        extraConfig = ''
          set -g @extrakto_clip_tool 'xsel -ib'
        '';
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
    ];
  };
}
