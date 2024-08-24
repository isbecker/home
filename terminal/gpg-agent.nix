{ flake, pkgs, ... }:
{
  services.gpg-agent = {
    enable = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    enableSshSupport = true;

    pinentryPackage = pkgs.pinentry-rofi;
    defaultCacheTtl = 84000;
    maxCacheTtl = 604800;
  };
}
