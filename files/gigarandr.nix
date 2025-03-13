{ pkgs, config, lib, flake, ... }:
{
  home.file."${config.xdg.configHome}/gigarandr/config.json" = {
    source = (pkgs.formats.json { }).generate "config-json"
      {
        xrandr_bin = "${lib.getExe pkgs.xorg.xrandr}";
        profiles =
          [
            {
              name = "docked";
              monitors = {
                laptop = {
                  name = "laptop";
                  primary = true;
                };
                largest = {
                  name = "largest";
                  position = "above laptop";
                };
              };
            }
            {
              name = "mobile";
              monitors = {
                laptop = {
                  name = "laptop";
                  primary = true;
                };
              };
            }
          ];
        hooks =
          {

            presync = [ ];
            sync = [ ];
            postsync = [
              # "${lib.getExe pkgs.autorandr} --cycle"
              "${pkgs.i3}/bin/i3-msg restart"
              "${pkgs.systemdMinimal}/bin/systemctl --user restart polybar.service"
            ];
          };
      };
  };

  home.packages = [
    flake.inputs.gigarandr.packages.${pkgs.system}.default
  ];
  # home.file."${config.xdg.configHome}/gigarandr/gigarandr.py" = {
  #   executable = true;
  #   text = builtins.readFile (builtins.fetchurl {
  #     url = "https://raw.githubusercontent.com/isbecker/gigarandr/v0.3.4/gigarandr.py";
  #     sha256 = "3b6831ea863ad34a5c9861045214fb2d19cfb5201b6f9414d5e5a6550a57c6ee";
  #   });
  # };
}
