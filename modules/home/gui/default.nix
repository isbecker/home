{ config, pkgs, ... }:
{
  imports = [
    ./librewolf.nix
    # ./vscode.nix
  ];

  home.packages = with pkgs; [
    qtpass
    # slack
  ];
}
