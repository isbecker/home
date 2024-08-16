{ flake, pkgs, ... }:
let 


in
{
  imports = [

    # desktop config; eg: i3, polybar, etc
    ./desktop

    # terminal config; eg: tmux, starship, etc
    ./terminal
    
    # firefox, vscode, etc
    ./gui

    # terminal apps; eg: k9s, neovim, etc
    ./terminal-apps
    
    # systemd services; eg: flameshot, barrier, etc
    ./services
  ];

  nixpkgs.config.allowUnfreePredicate = _: true;

  news.display = "show";

  home.sessionVariables = {
    XDG_CURRENT_DESKTOP = "i3";
    TERMINAL = "kitty";
    EDITOR = "nvim";
    BROWSER = "firefox";

    GITLAB_HOST = "cm.infra.he2pi.com";
    GITLAB_URI = "https://cm.infra.he2pi.com";
    GITLAB_API_URL = "https://cm.infra.he2pi.com/api/v4";
    GITLAB_TOKEN = "$(${pkgs.pass}/bin/pass show git/cm.infra.he2pi.com/ian.becker)";

    JIRA_API_TOKEN = "$(${pkgs.pass}/bin/pass show dev/jira/tokens/pat)";
    JIRA_AUTH_TYPE = "bearer";

    VAULT_ADDR = "https://vault.infra.prod.gov.he2pi.com/";
    VAULT_TOKEN = "s.osWPnr7BGrWek69xtd0M45Yb";

    # MONITOR = "DP-2";
  };

  nix = {
    gc = {
      automatic = true;
      frequency = "weekly";
    };
  };

  # Nix packages to install to $HOME
  #
  # Search for packages here: https://search.nixos.org/packages
  home.packages = with pkgs; [

    # Nix dev
    cachix

    go

    (nerdfonts.override { fonts = [ "Hack" "Iosevka" "IosevkaTerm" "IosevkaTermSlab"  ]; })
  ];

  fonts.fontconfig.enable = true;

  programs = {
    home-manager.enable = true;
  };

  home.file.".xsession" = {
    text = ''
      #!${pkgs.bash}/bin/bash
      exec ${pkgs.i3}/bin/i3
    '';
    executable = true;
  };

  xdg = {
    portal = {
      enable = true;
      configPackages = [ pkgs.gnome.gnome-session ];
      extraPortals = [ pkgs.xdg-desktop-portal-gnome pkgs.xdg-desktop-portal-gtk ];
      config = {
        common = {
          default = [
            "gtk"
          ];
          "org.freedesktop.impl.portal.ScreenCast" = [
            "gnome"
          ];
        };
        i3 = {
          default = [
            "gtk"
          ];
        };
      };
    };
  };
}
