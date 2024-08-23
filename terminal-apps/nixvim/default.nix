{ flake, pkgs, ... }:
{
  imports = [
    flake.inputs.nixvim.homeManagerModules.nixvim
    ./nixvim.nix
    ./plugins/telescope.nix
  ];
}
