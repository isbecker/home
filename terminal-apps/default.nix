{ flake, pkgs, ... }:
{
  imports = [
    ./nixvim
    ./awscli.nix
    ./btop.nix
    ./git-cliff.nix
    ./gitlab.nix
    ./gitui.nix
    ./joshuto.nix
    ./jq.nix
    ./k9s.nix
    ./ranger.nix
  ];

  home.packages = with pkgs; [
    # On ubuntu, we need this less for `man home-configuration.nix`'s pager to
    # work.
    less

    pass
    pass-git-helper

    gpg-tui

    jira-cli-go

    vault
  ];
}
