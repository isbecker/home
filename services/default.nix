{ flake, pkgs, ... }:
{
  imports = [
    ./activity-watch.nix
    ./barrier.nix
    ./flameshot.nix
    ./globalprotect.nix
  ];

  services.copyq.enable = true;
}
