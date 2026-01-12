{ pkgs, ... }:
{
  imports = [
    ./dunst.nix
    ./fusuma.nix
    ./i3.nix
    ./picom.nix
    ./polybar.nix
    ./rofi.nix

    ./kanshi.nix
    ./sway.nix
    ./waybar.nix
  ];

  programs.feh.enable = true;

  home.packages = with pkgs; [
    i3lock-color
    autorandr
    pavucontrol
  ];
}
