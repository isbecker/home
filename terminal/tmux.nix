{ flake, pkgs, ... }:
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
      '';
      plugins =  with pkgs; [
        {
          plugin = tmuxPlugins.yank;
        }
        {
          plugin = tmuxPlugins.tmux-fzf;
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

          set -g @catppuccin_window_left_separator ""
          set -g @catppuccin_window_right_separator " "
          set -g @catppuccin_window_middle_separator " █"
          set -g @catppuccin_window_number_position "right"

          set -g @catppuccin_window_default_fill "number"
          set -g @catppuccin_window_default_text "#W"

          set -g @catppuccin_window_current_fill "number"
          set -g @catppuccin_window_current_text "#W"

          set -g @catppuccin_status_modules_right "directory date_time session"
          set -g @catppuccin_status_left_separator  " "
          set -g @catppuccin_status_right_separator ""
          set -g @catppuccin_status_right_separator_inverse "no"
          set -g @catppuccin_status_fill "icon"
          set -g @catppuccin_status_connect_separator "no"

          set -g @catppuccin_directory_text "#{pane_current_path}"

          set -g @catppuccin_date_time_text "%Y-%m-%d %H:%M:%S"
          '';
        }
      ];
    };
}