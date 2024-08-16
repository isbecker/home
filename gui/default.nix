{ flake, pkgs, ... }:
{
  imports = [
    ./firefox.nix
    ./vscode.nix
  ];

  home.packages = with pkgs; [
    qtpass
    slack
    # zoom-us
    seabird
  ];
}
