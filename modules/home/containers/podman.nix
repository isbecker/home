{ pkgs, config, ... }:
{
  xdg.configFile."cdi/.created".text = "";
  systemd.user.services.podman-cdi = {
    Unit = {
      Description = "Podman CDI creator";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      Type = "oneshot";
      ExecStart = ''
        ${(config.lib.nixGL.wrappers.nvidia pkgs.nvidia-container-toolkit)}/bin/nvidia-ctk cdi generate --output=${config.xdg.configHome}/cdi/nvidia.yaml
      '';
    };
  };
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
      containers = {
        engine = {
          # This is currently not supported by podman 😢
          # watching 
          # - https://github.com/containers/podman/issues/18292
          # - https://github.com/containers/podman/pull/21448
          cdi_spec_dirs = [ "${config.xdg.configHome}/cdi" ];
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



