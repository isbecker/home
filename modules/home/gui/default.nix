{ config, pkgs, ... }:
{
  imports = [
    ./librewolf.nix
    ./vscode.nix
  ];

  home.packages = with pkgs; [
    qtpass
    discord-krisp
    signal-desktop
    bazecor
  ];
}
