{ flake, config, pkgs, lib, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    inputs.catppuccin.homeModules.catppuccin
    inputs.nur.modules.homeManager.default
    # inputs.chaotic.homeManagerModules.default
    self.homeModules.default
  ];
  catppuccin = {
    enable = true;
    mako.enable = false; # https://github.com/nix-community/home-manager/commit/d1bbab6b04d865d759505f33a5c6743bbb544074
    flavor = "macchiato";
    accent = "lavender";
    cursors = {
      enable = true;
      flavor = config.catppuccin.flavor;
      accent = config.catppuccin.accent;
    };
    # gtk = {
    #   enable = true;
    #   flavor = config.catppuccin.flavor;
    #   accent = config.catppuccin.accent;
    #   icon = {
    #     enable = true;
    #     flavor = config.catppuccin.flavor;
    #     accent = config.catppuccin.flavor;
    #   };
    # };
  };

  # Defined by /modules/home/me.nix
  # And used all around in /modules/home/*
  me = {
    username = "ibecker";
    fullname = "Ian Becker";
    email = "ian@beckr.dev";
  };


  home.stateVersion = "24.11";

  home.pointerCursor = {
    x11.enable = true;
  };

  home.activation.afterWriteBoundary = {
    after = [ "writeBoundary" ];
    before = [ ];
    data = ''
      rm -rf ${config.xdg.configHome}/Code/User/settings.json
      rm -rf ${config.home.homeDirectory}/.vscode/extensions
      find ~/.config/Code | while read -r path
      do
        $DRY_RUN_CMD chmod --recursive +w \
          "$(readlink --canonicalize "$path")"
      done
    '';
  };

  home.packages = with pkgs; [
    home-manager
    devenv

    # (inputs.krew2nix.packages.x86_64-linux.kubectl.withKrewPlugins (plugins: [
    #   plugins.view-secret
    #   # plugins.pickdeep
    #   plugins.node-shell
    # ]))
  ];

  # services.screen-locker = {
  #   enable = true;
  #   lockCmd = "${lib.getExe pkgs.i3lock-color}";
  # };

}
