{ flake, pkgs, ...}:
{
  programs.awscli = {
    enable = true;
  };
}