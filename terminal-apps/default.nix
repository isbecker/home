{ flake, pkgs, ... }:
{
    imports = [
      ./awscli.nix
      ./btop.nix
      ./git-cliff.nix
      ./gitui.nix
      ./joshuto.nix
      ./jq.nix
      ./k9s.nix
      ./neovim.nix
      ./ranger.nix
    ];

    home.packages = with pkgs; [
      # On ubuntu, we need this less for `man home-configuration.nix`'s pager to
      # work.
      less
      
      pass
      pass-git-helper
      
      gpg-tui
      
      glab # gitlab cli
      jira-cli-go

      podman
      podman-compose

      vault

      kubectl
      kind
      k3d
      crossplane-cli
      argocd
      kubernetes-helm
    ];
}