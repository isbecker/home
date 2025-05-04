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
  programs.gpg = {
    enable = true;
    # https://support.yubico.com/hc/en-us/articles/4819584884124-Resolving-GPG-s-CCID-conflicts
    scdaemonSettings = {
      disable-ccid = true;
    };
  };
}
