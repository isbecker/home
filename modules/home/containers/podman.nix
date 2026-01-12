{ pkgs, config, ... }:
{

  services.podman = {
    enable = true;
    settings = {
      policy = {
        default = [{ type = "insecureAcceptAnything"; }];
        transports = {
          docker-daemon = {
            "" = [{ type = "insecureAcceptAnything"; }];
          };
        };
      };
    };
  };
  home.packages = with pkgs; [
    podman-compose
    # lazydocker
  ];
  #
  # home.sessionVariables = {
  #   # DOCKER_HOST = "unix://$XDG_RUNTIME_DIR/podman/podman.sock";
  #   # DOCKER_SOCK = "unix:/$XDG_RUNTIME_DIR/podman/podman.sock";
  # };
  #
  home.shellAliases = {
    docker = "podman";
  };
  # # systemd.user.services = {
  # #   "podman.socket" = {
  # #     Unit = {
  # #       Description = "Start Podman socket.";
  # #     };
  # #     Install = {
  # #       WantedBy = [ "default.target" ];
  # #     };
  # #     Service = {
  # #       ExecStart = "${pkgs.podman}/bin/podman system service --time=0";
  # #     };
  # #   };
  # # };
}



