{ pkgs, ... }:
{
  imports = [
    # ./acm.nix
  ];
  programs.go = {
    enable = true;
    package = pkgs.go_1_23;
  };
}
