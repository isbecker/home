# See /modules/nixos/* for actual settings
# This file is just *top-level* configuration.
{ flake, lib, ... }:

let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    self.nixosModules.default
    self.nixosModules.gui
    self.nixosModules.games
    self.nixosModules.mobo
    ./configuration.nix
    flake.inputs.catppuccin.nixosModules.catppuccin
  ];
  home-manager.useGlobalPkgs = lib.mkForce false;
  home-manager.backupFileExtension = "backup";
}
