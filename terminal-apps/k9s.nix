{ flake, pkgs, ... }:
{
  programs.k9s = {
    enable = true;
    aliases = {
      aliases = {
        pp = "v1/pods";
      };
    };
  };
}
