{ flake, pkgs, ... }:
{
  services.barrier = {
    client = {
      enable = true;
      server = "192.168.1.174:24800";
    };
  };
}
