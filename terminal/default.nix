{ pkgs, ... }:
{
  imports = [
    ./aliases.nix
    ./carapace.nix
    ./eza.nix
    ./fish.nix
    ./git.nix
    ./ghostty.nix
    ./gpg-agent.nix
    ./jujutsu.nix
    ./kitty.nix
    ./nushell.nix
    ./starship.nix
    ./tmux.nix
  ];

  programs = {
    fzf = {
      enable = true;
      enableFishIntegration = true;
      # enableNushellIntegration = true;
      tmux.enableShellIntegration = true;
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    fd = {
      enable = true;
    };
    thefuck = {
      enable = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
    };

    dircolors = {
      enable = true;
      enableFishIntegration = true;
      # enableNushellIntegration = true;
    };
  };

  home.packages = with pkgs; [
    ripgrep # Better `grep`
    xsel
    brightnessctl

    nurl # possibly we may start a nix-tools file if we end up with more

    bat

    curl
  ];
}
