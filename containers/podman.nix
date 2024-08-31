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

  home.sessionVariables = {
    docker = "podman";
  };

  home.file."${config.xdg.configHome}/containers/registries.conf" = {
    text = ''
      unqualified-search-registries=["docker.io"]
    '';
  };
  home.file."${config.xdg.configHome}/containers/policy.json" =
    {
      text = ''
        {
          "default": [
            {
              "type": "insecureAcceptAnything"
            }
          ]
        }
      '';
    };

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
