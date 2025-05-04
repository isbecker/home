{ flake, pkgs, config, nixgl, ... }:
{

  nixpkgs.config.allowUnfreePredicate = _: true;

  news.display = "show";

  home.sessionVariables = {
    XDG_CURRENT_DESKTOP = "i3";
    TERMINAL = "ghostty";
    EDITOR = "nvim";
    BROWSER = "librewolf";
    PAGER = "${pkgs.moar}/bin/moar";
    MOAR = "--style=catppuccin-macchiato";
  };

  # Nix packages to install to $HOME
  #
  # Search for packages here: https://search.nixos.org/packages
  home.packages = with pkgs; [

    nerd-fonts.iosevka
    nerd-fonts.iosevka-term
    nerd-fonts.iosevka-term-slab
  ];

  fonts.fontconfig.enable = true;

  programs = {
    home-manager.enable = true;
  };

}
