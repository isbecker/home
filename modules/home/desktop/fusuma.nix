{ flake, pkgs, ... }:
{
  services.fusuma = {
    enable = true;
    settings = {
      threshold = {
        swipe = 0.4;
        pinch = 0.4;
      };
      interval = {
        swipe = 0.8;
        pinch = 0.1;
      };
      swipe = {
        "3" = {
          left = {
            command = "${pkgs.i3}/bin/i3-msg 'workspace next_on_output'";
          };
          right = {
            command = "${pkgs.i3}/bin/i3-msg 'workspace prev_on_output'";
          };
        };
        "4" = {
          left = {
            command = "${pkgs.xdotool}/bin/xdotool click 9";
          };
          right = {
            command = "${pkgs.xdotool}/bin/xdotool click 8";
          };
        };
      };
      # pinch = {
      #   "in" = {
      #     command =  "${pkgs.xdotool}/bin/xdotool key ctrl+shift+plus";
      #   };

      #   "out" = {
      #     command =  "${pkgs.xdotool}/bin/xdotool key ctrl+shift+minus";
      #   };
      # };
    };
  };
}
