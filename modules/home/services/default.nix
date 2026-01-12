{ flake, pkgs, ... }:
{
  imports = [
    ./activity-watch.nix
    ./flameshot.nix
    # ./podman.nix
  ];

  # services.copyq.enable = true;
}
