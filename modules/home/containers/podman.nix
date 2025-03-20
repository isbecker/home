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
      # registries = { };
      # registries.search = [
      #   "docker.io"
      #   "docker.infra.prod.gov.he2pi.com"
      #   "quay.io"
      # ];
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
  #
  # home.file."${config.xdg.configHome}/containers/registries.conf" = {
  #   source = (pkgs.formats.toml { }).generate "registries-conf" {
  #     unqualified-search-registries = [
  #       "docker.io"
  #     ];
  #     registry = [
  #       {
  #         location = "docker.infra.prod.gov.he2pi.com";
  #       }
  #     ];
  #   };
  # };
  # home.file."${config.xdg.configHome}/containers/policy.json" =
  #   {
  #     source = (pkgs.formats.json { }).generate "policy-json" {
  #       default = [
  #         {
  #           type = "insecureAcceptAnything";
  #         }
  #       ];
  #     };
  #   };
  #
  # # home.services.podman = {
  # #   enable = true;
  # # };
  #
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



