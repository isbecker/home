{ flake, pkgs, lib, config, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    inputs.chaotic.nixosModules.default
  ];
  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_cachyos;
  services.scx = {
    enable = true;
    scheduler = "scx_lavd";
  };
  # chaotic.hdr.enable = true;
}

