{ flake, pkgs, ... }:
{
  services.dunst = {
    enable = false;
    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };
  };
}
