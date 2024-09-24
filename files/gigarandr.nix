{ pkgs, config, ... }:
{
  home.file."${config.xdg.configHome}/gigarandr/config.json" = {
    source = (pkgs.formats.json { }).generate "config-json" {
      profiles =
        [
          {
            name = "docked";
            monitors = [
              {
                name = "laptop";
                primary = true;
                position = "below largest";
              }
              {
                name = "largest";
                position = "above laptop";
              }
            ];
          }
          {
            name = "mobile";
            monitors = [
              {
                name = "laptop";
                primary = true;
              }
            ];
          }
        ];
      hooks =
        {

          presync = [
            "echo 'PreSync Hook: Starting...'"
          ];
          sync = [
            "echo 'Sync Hook: Adjusting monitor settings...'"
          ];
          postsync = [
            "echo 'PostSync Hook: Clean-up operations completed.'"
            "autorandr --cycle"
            "systemctl --user restart polybar.service"
          ];
        };
    };

  };

  home.file."${config.xdg.configHome}/gigarandr/gigarandr.py" = {
    executable = true;
    text = builtins.readFile (builtins.fetchurl {
      url = "https://raw.githubusercontent.com/isbecker/gigarandr/v0.3.2/gigarandr.py";
      sha256 = "0b397m640qzxr8g0nalifj4h8rj52ypshp2ax6p6gp3jshs19r47";
    });
  };
}
