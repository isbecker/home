{ flake, pkgs, ... }:
{
  programs.fish = {
    enable = true;
    loginShellInit = ''
      set -gx PATH $PATH $HOME/.local/bin /usr/local/go/bin
    '';

    interactiveShellInit = ''
      fzf_configure_bindings --directory=\cf
      # chainsaw completion fish | source
    '';

    plugins = [
      { name = "bass"; src = pkgs.fishPlugins.bass.src; }
      { name = "forgit"; src = pkgs.fishPlugins.forgit.src; }
      { name = "autopair"; src = pkgs.fishPlugins.autopair.src; }
      { name = "z"; src = pkgs.fishPlugins.z.src; }
      { name = "done"; src = pkgs.fishPlugins.done.src; }
      {
        # nix-prefetch-github --rev v10.2 PatrickF1 fzf.fish
        name = "fzf.fish";
        src = pkgs.fetchFromGitHub {
          owner = "PatrickF1";
          repo = "fzf.fish";
          rev = "85503fbc4b6026c616dd5dc8ebb4cfb82e1ef16c"; # v10.2
          sha256 = "sha256-1/MLKkUHe4c9YLDrH+cnL+pLiSOSERbIZSM4FTG3wF0=";
        };
      }
    ];
    functions = {
      fzf = {
        body =
          ''
            if set --query TMUX
              fzf-tmux $argv
            else
              command fzf $argv
            end
          '';
        wraps = "fzf";
        description = "Use fzf-tmux if in tmux session";
      };
    };
  };

}
