{ config, ... }:
let
  dataDir = "${config.xdg.dataHome}/open-webui";
in
{
  # just touch these files to ensure the proper folder structs
  xdg.dataFile."${dataDir}/.created".text = "";
  services.podman.containers.open-webui = {
    autoStart = true;
    autoUpdate = "registry";
    image = "ghcr.io/open-webui/open-webui:main";
    volumes = [
      "${dataDir}:/app/backend/data"
    ];
    ports = [
      "3000:8080"
    ];
    environment = {
      TZ = "US/Eastern";
    };
    extraPodmanArgs = [ "--device nvidia.com/gpu=all" ];
    labels = {
      app = "open-webui";
    };
  };

}
