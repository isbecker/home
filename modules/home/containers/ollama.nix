{ config, ... }:
let
  dataDir = "${config.xdg.dataHome}/ollama";
in
{
  # just touch these files to ensure the proper folder structs
  xdg.dataFile."${dataDir}/.created".text = "";
  services.podman.containers.ollama = {
    autoStart = true;
    autoUpdate = "registry";
    image = "docker.io/ollama/ollama:latest";
    volumes = [
      "${dataDir}:/root/.ollama"
    ];
    ports = [
      "11434:11434"
    ];
    environment = {
      TZ = "US/Eastern";
    };
    extraPodmanArgs = [ "--device nvidia.com/gpu=all" ];
    labels = {
      app = "ollama";
    };
  };
}
