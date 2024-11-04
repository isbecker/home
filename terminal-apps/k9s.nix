{ flake, pkgs, ... }:
{
  programs.k9s = {
    enable = true;
    aliases = {
      aliases = {
        pp = "v1/pods";
      };
    };
    settings = {
      k9s = {
        liveViewAutoRefresh = true;
      };
    };
  };
}
