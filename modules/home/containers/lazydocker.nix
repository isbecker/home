{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    lazydocker
  ];
  home.file."${config.xdg.configHome}/lazydocker/config.yml" = {
    source = (pkgs.formats.yaml { }).generate "config-yaml" {
      gui = {
        returnImmediately = true;
        scrollHeight = 2;
        border = "rounded";
        theme = {
          activeBorderColor = [
            "green"
            "bold"
          ];
          inactiveBorderColor = [
            "white"
          ];
          selectedLineBgColor = [
            "blue"
          ];
          optionsTextColor = [
            "blue"
          ];
        };
      };
    };
  };
}
