{ flake, pkgs, lib, config, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
  inherit (flake.config) me;
in
{
  imports = [
    self.homeModules.default
    inputs.catppuccin.homeManagerModules.catppuccin
    inputs.nur.modules.homeManager.default
    inputs.nixvim.homeManagerModules.nixvim
  ];
  catppuccin = {
    enable = true;
    flavor = "macchiato";
  };

  #nixGL = {
  #  packages = inputs.nixgl.packages;
  #  defaultWrapper = "mesa";
  #  offloadWrapper = "nvidia";
  #};


  # To use the `nix` from `inputs.nixpkgs` on templates using the standalone `home-manager` template

  # `nix.package` is already set if on `NixOS` or `nix-darwin`.
  # TODO: Avoid setting `nix.package` in two places. Does https://github.com/juspay/nixos-unified-template/issues/93 help here?
  nix.package = lib.mkDefault pkgs.nix;
  home.packages = with pkgs; [
    config.nix.package

    discord
    signal-desktop
  ];

  home.username = me.username;
  home.homeDirectory = lib.mkDefault "/${if pkgs.stdenv.isDarwin then "Users" else "home"}/${me.username}";
  home.stateVersion = "24.11";
}
