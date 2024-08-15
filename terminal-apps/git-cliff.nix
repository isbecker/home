{ flake, pkgs, ...}:
{
  programs.git-cliff = {
    enable = true;
  };
}