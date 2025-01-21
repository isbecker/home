{ flake, pkgs, ... }:
{
  imports = [
    ./barbecue.nix
    ./conform.nix
    ./flash.nix
    ./telescope.nix
    ./cmp.nix
    ./which-key.nix
    ./toggleterm.nix
    ./persistence.nix
  ];
}
