{ config, pkgs, ... }:
{
  imports = [
    ./firefox.nix
    ./vscode.nix
  ];

  home.packages = with pkgs; [
    qtpass
    slack
    # (config.lib.nixGL.wrappers.nvidiaPrime zoom-us)
  ];
}
