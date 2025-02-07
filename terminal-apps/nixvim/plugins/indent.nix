{
  programs.nixvim = {
    plugins = {
      indent-blankline = {
        enable = true;
        settings = {
          indent = {
            highlight = [
              "RainbowRed"
              "RainbowYellow"
              "RainbowBlue"
              "RainbowOrange"
              "RainbowGreen"
              "RainbowViolet"
              "RainbowCyan"
            ];
          };
        };
      };
      indent-o-matic = {
        enable = true;
        settings = {
          max_lines = 2048;
          skip_multiline = false;
          standard_widths = [
            2
            4
            8
          ];
        };
      };
    };
  };
}
