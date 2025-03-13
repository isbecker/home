{ config, pkgs, ... }:
{
  imports = [
    ./firefox.nix
    # ./ladybird.nix
    ./vscode.nix
  ];

  home.packages = with pkgs; [
    qtpass
    slack
    # (config.lib.nixGL.wrappers.nvidiaPrime zoom-us)
  ];
}
