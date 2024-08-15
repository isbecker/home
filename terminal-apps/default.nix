{ flake, pkgs, ... }:
let
  gitlabCli = pkgs.stdenv.mkDerivation {
    pname = "gitlab-cli";
    version = "1.45.0";
    src = builtins.fetchTarball {
      url = "https://gitlab.com/gitlab-org/cli/-/package_files/140883199/download";
      sha256 = "16ayn4k5gbzl6909vcfc4wqx66hx0xngndj6b3a9phc0wsj9gjcx";
    };
    installPhase = ''
      mkdir -p $out/bin
      install -m755 glab $out/bin/glab
    '';
  };
in
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
      
      # glab # gitlab cli, hasn't been updated in a while...
      gitlabCli # the fetchTarball above is from the latest release
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