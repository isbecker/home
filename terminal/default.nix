{ flake, pkgs, ... }:
{
  imports = [
    ./carapace.nix
    ./eza.nix
    ./fish.nix
    ./git.nix
    ./gpg-agent.nix
    ./jujutsu.nix
    ./k8s-utils.nix
    ./kitty.nix
    ./nushell.nix
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
  ];
}
