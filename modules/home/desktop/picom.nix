{ flake, pkgs, ... }:
{
  services.picom = {
    enable = true;
    fade = true;
    fadeDelta = 5;
    backend = "glx";
    vSync = true;

    settings = {
      # corner-radius = 10.0;
      # round-borders = 10;
      # unredir-if-possible = false;
      blur = {
        method = "dual_kawase";
        # size = 10;
        strength = 5;
        background = false;
        background-frame = false;
        background-fixed = false;
        kern = "3x3box";
      };
    };
    opacityRules = [
      "90:class_g = 'kitty' && focused"
      "60:class_g = 'kitty' && !focused"
      "90:class_g = 'com.mitchellh.ghostty' && focused"
      "60:class_g = 'com.mitchellh.ghostty' && !focused"
      "90:class_g = 'Code' && focused"
      "60:class_g = 'Code' && !focused"

      "90:class_g = 'Rofi'"
    ];
  };
}
