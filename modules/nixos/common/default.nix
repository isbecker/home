{ pkgs, ... }:
{
  imports = [
    ./myusers.nix
    ./nix-ld.nix
    ./scx.nix
  ];

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;


}
