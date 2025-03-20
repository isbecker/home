# See /modules/nixos/* for actual settings
# This file is just *top-level* configuration.
{ flake, lib, ... }:

let
  inherit (flake) inputs;
  inherit (inputs) self;
  inherit (flake.config) me;
in
{
  imports = [
    self.nixosModules.default
    self.nixosModules.gui
    self.nixosModules.games
    ./configuration.nix
  ];

  home-manager.useGlobalPkgs = lib.mkForce false;
  home-manager.backupFileExtension = "backup";

  # Enable home-manager for our user
  home-manager.users."${me.username}" = {
    imports = [ (self + /configurations/home/${me.username}.nix) ];
  };
}
