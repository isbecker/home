{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    podman
    podman-compose
    # lazydocker
  ];

  home.sessionVariables = {
    # DOCKER_HOST = "unix://$XDG_RUNTIME_DIR/podman/podman.sock";
    # DOCKER_SOCK = "unix:/$XDG_RUNTIME_DIR/podman/podman.sock";
  };

  home.shellAliases = {
    docker = "podman";
  };

  home.file."${config.xdg.configHome}/containers/registries.conf" = {
    source = (pkgs.formats.toml { }).generate "registries-conf" {
      unqualified-search-registries = [
        "docker.io"
      ];
      registry = [
        {
          location = "docker.infra.prod.gov.he2pi.com";
        }
      ];
    };
  };
  home.file."${config.xdg.configHome}/containers/policy.json" =
    {
      source = (pkgs.formats.json { }).generate "policy-json" {
        default = [
          {
            type = "insecureAcceptAnything";
          }
        ];
      };
    };

  # home.services.podman = {
  #   enable = true;
  # };

  # systemd.user.services = {
  #   "podman.socket" = {
  #     Unit = {
  #       Description = "Start Podman socket.";
  #     };
  #     Install = {
  #       WantedBy = [ "default.target" ];
  #     };
  #     Service = {
  #       ExecStart = "${pkgs.podman}/bin/podman system service --time=0";
  #     };
  #   };
  # };
}
