{ config, pkgs, ... }:
{
  imports = [
    ./godot.nix
    ./librewolf.nix
    ./vscode.nix
  ];

  home.packages = with pkgs; [
    qtpass
    discord
    signal-desktop
    bazecor
    protonvpn-gui
  ];


}
