{ flake, pkgs, ...}:
{
  imports = [
    ./carapace.nix
    ./eza.nix
    ./fish.nix
    ./git.nix
    ./gpg-agent.nix
    ./kitty.nix
    ./starship.nix
    ./tmux.nix
  ];

  home.shellAliases = {
    asl = "aws_sso_login";
    uac = "update_aws_config";
    uek = "update_eks_kubeconfig";

    docker = "podman";
  };

  programs = {
    fzf = {
      enable = true;
      enableFishIntegration = true;
      tmux.enableShellIntegration = true;
    };
    direnv = {
      enable = true;
    };
    fd = {
      enable = true;
    };
    thefuck = {
      enable = true;
      enableFishIntegration = true;
    };
  };

  home.packages = with pkgs; [
    ripgrep # Better `grep`
    xsel
    brightnessctl
  ];
}