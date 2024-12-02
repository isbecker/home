{ flake, pkgs, ... }:
{
  programs.eza = {
    enable = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    git = true;
    icons = "auto";
  };
}
