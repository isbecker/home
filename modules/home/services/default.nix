{ flake, pkgs, ... }:
{
  imports = [
    ./activity-watch.nix
    ./barrier.nix
    ./flameshot.nix
    # ./podman.nix
  ];

  # services.copyq.enable = true;
}
