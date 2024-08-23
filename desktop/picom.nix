{ flake, pkgs, ... }:
{
  services.picom = {
    enable = true;
    backend = "xr_glx_hybrid";
    fade = true;
    fadeDelta = 5;
    vSync = true;

    opacityRules = [
      "90:class_g = 'kitty' && focused"
      "60:class_g = 'kitty' && !focused"
    ];
  };
}
