# This is your nixos configuration.
# For home configuration, see /modules/home/*
{ flake, pkgs, ... }:
{
  imports = [
    flake.inputs.self.nixosModules.common
  ];
  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };
  services.openssh.enable = true;
  services.pcscd.enable = true;
  services.udev.packages = [ pkgs.yubikey-personalization ];
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
