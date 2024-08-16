{ flake, pkgs, ... }:
{
  imports = [
    ./activity-watch.nix
    ./barrier.nix
    ./flameshot.nix
  ];
}
