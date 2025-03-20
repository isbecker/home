{ pkgs, ... }:
{
  # Nix packages to install to $HOME
  #
  # Search for packages here: https://search.nixos.org/packages
  home.packages = with pkgs; [
    # Unix tools
    sd
    tree
    gnumake

    # Nix dev
    cachix
    nil # Nix language server
    nix-info
    nixpkgs-fmt


    # On ubuntu, we need this less for `man home-configuration.nix`'s pager to
    # work.
    less

    protonup-qt
    protonup-ng
    yubikey-manager
  ];

  # Programs natively supported by home-manager.
  # They can be configured in `programs.*` instead of using home.packages.
  programs = {
    jq.enable = true;
    # Install btop https://github.com/aristocratos/btop
    btop.enable = true;
    # Tmate terminal sharing.
    tmate = {
      enable = true;
      #host = ""; #In case you wish to use a server other than tmate.io 
    };
  };
}
