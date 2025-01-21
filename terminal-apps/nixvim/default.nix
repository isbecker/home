{ flake, pkgs, ... }:
{
  imports = [
    ./nixvim.nix
    ./plugins
  ];
}
