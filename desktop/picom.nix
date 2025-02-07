{ flake, pkgs, ... }:
{
  services.picom = {
    enable = true;
    fade = true;
    fadeDelta = 5;
    vSync = true;

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
