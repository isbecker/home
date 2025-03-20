{ config, pkgs, ... }:
{
  imports = [
    ./firefox.nix
    # ./vscode.nix
  ];

  home.packages = with pkgs; [
    qtpass
    # slack
  ];
}
