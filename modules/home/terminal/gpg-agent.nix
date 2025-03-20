{ flake, pkgs, ... }:
{
  services.gpg-agent = {
    enable = true;
    # enableExtraSocket = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    enableSshSupport = true;

    pinentryPackage = pkgs.pinentry-rofi;
    defaultCacheTtl = 84000;
    defaultCacheTtlSsh = 84000;
    maxCacheTtl = 604800;
    maxCacheTtlSsh = 604800;
  };
  home.packages = with pkgs; [
    gnupg
  ];
}
