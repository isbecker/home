{ flake, pkgs, ... }:
{
  imports = [
    flake.inputs.nixvim.homeManagerModules.nixvim
    ./nixvim.nix
    ./plugins/telescope.nix
    ./plugins/cmp.nix
    ./plugins/which-key.nix
  ];
}
