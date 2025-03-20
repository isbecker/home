{ config, ... }:
let
  freshrss_dir = "${config.xdg.dataHome}/freshrss";
  dataDir = "${freshrss_dir}/freshrss_data";
  extDir = "${freshrss_dir}/freshrss_extensions";
in
{
  # just touch these files to ensure the proper folder structs
  xdg.dataFile."${dataDir}/.created".text = "";
  xdg.dataFile."${extDir}/.created".text = "";

  services.podman.containers.freshrss = {
    autoStart = true;
    autoUpdate = "registry";
    image = "docker.io/freshrss/freshrss:latest";
    volumes = [
      "${dataDir}:/var/www/FreshRSS/data"
      "${extDir}:/var/www/FreshRSS/extensions"
    ];
    ports = [
      "8080:80"
    ];
    environment = {
      TZ = "US/Eastern";
      CRON_MIN = "1,31";
    };
    labels = {
      app = "freshrss";
    };
  };
}
