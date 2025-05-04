{ flake, config, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    inputs.catppuccin.homeModules.catppuccin
    inputs.nur.modules.homeManager.default
    inputs.nixvim.homeManagerModules.nixvim
    inputs.chaotic.homeManagerModules.default
    self.homeModules.default
  ];
  catppuccin = {
    enable = true;
    # grub.enable = true;
    flavor = "macchiato";
    accent = "lavender";
    cursors = {
      enable = true;
      flavor = config.catppuccin.flavor;
      accent = config.catppuccin.accent;
    };
    gtk = {
      enable = true;
      flavor = config.catppuccin.flavor;
      accent = config.catppuccin.accent;
      icon = {
        enable = true;
        flavor = config.catppuccin.gtk.flavor;
        accent = config.catppuccin.gtk.accent;
      };
    };
  };

  # Defined by /modules/home/me.nix
  # And used all around in /modules/home/*
  me = {
    username = "ibecker";
    fullname = "Ian Becker";
    email = "johndoe@dream.com";
  };

  home.stateVersion = "24.11";

  home.pointerCursor = {
    x11.enable = true;
  };
}
