{ flake, pkgs, ... }:
{
  imports = [
    ./nixvim.nix
    ./plugins/telescope.nix
    ./plugins/cmp.nix
    ./plugins/which-key.nix
  ];
}
