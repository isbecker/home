{ flake, pkgs, config, lib, ... }:


let
  namespace = "default";
  buildkitArgs = lib.concatStringsSep " " (lib.cli.toGNUCommandLine { } {
    oci-worker = "false";
    containerd-worker = "true";
    containerd-worker-rootless = "true";
    addr = "unix:///run/user/1000/buildkit-${namespace}/buildkitd.sock";
    root = "${config.xdg.dataHome}/buildkit-${namespace}";
    containerd-worker-namespace = "${namespace}";
    containerd-worker-net = "host";
  });
  nsenter = pkgs.writeShellApplication {
    name = "containerd-nsenter";
    runtimeInputs = [
      pkgs.util-linux
      "/run/current-system/sw"
    ];
    text = ''
      pid=$(<"$XDG_RUNTIME_DIR/containerd-rootless/child_pid")
      exec nsenter \
        --no-fork \
        --preserve-credentials \
        --mount \
        --net \
        --user \
        --target "$pid" \
        -- "$@"
    '';
  };
in
{
  systemd.user.services.buildkitd = {
    Unit = {
      Description = "BuildKit (Rootless)";
      PartOf = "containerd.service";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      Environment = "PATH=${pkgs.buildkit}/bin:${pkgs.git}/bin:${pkgs.runc}/bin:/sbin:/usr/sbin:$PATH";
      Type = "simple";
      Restart = "always";
      RestartSec = "2";
      KillMode = "mixed";
      NotifyAccess = "all";
      StateDirectory = "buildkitd";
      RuntimeDirectory = "buildkitd";
      RuntimeDirectoryPreserve = "yes";
      ExecReload = "${pkgs.procps}/bin/kill -s HUP $MAINPID";
      ExecStart = "${nsenter}/bin/containerd-nsenter ${pkgs.buildkit}/bin/buildkitd ${buildkitArgs}";
    };
  };
}

# 	UNIT_NAME=${SYSTEMD_BUILDKIT_UNIT}
# 	BUILDKITD_FLAG="--oci-worker=false --containerd-worker=true --containerd-worker-rootless=true"
# 	if [ -n "${CONTAINERD_NAMESPACE:-}" ]; then
# 		UNIT_NAME="${CONTAINERD_NAMESPACE}-${SYSTEMD_BUILDKIT_UNIT}"
# 		BUILDKITD_FLAG="${BUILDKITD_FLAG} --addr=unix://${XDG_RUNTIME_DIR}/buildkit-${CONTAINERD_NAMESPACE}/buildkitd.sock --root=${XDG_DATA_HOME}/buildkit-${CONTAINERD_NAMESPACE} --containerd-worker-namespace=${CONTAINERD_NAMESPACE}"
# 	else
# 		WARNING "buildkitd has access to images in \"buildkit\" namespace by default. If you want to give buildkitd access to the images in \"default\" namespace, run this command with CONTAINERD_NAMESPACE=default"
# 	fi
# 	if [ -n "${CONTAINERD_SNAPSHOTTER:-}" ]; then
# 		BUILDKITD_FLAG="${BUILDKITD_FLAG} --containerd-worker-snapshotter=${CONTAINERD_SNAPSHOTTER}"
# 	fi
# 	if buildkitd --help | grep -q bridge; then
# 		# Available since BuildKit v0.13
# 		BUILDKITD_FLAG="${BUILDKITD_FLAG} --containerd-worker-net=bridge"
# 	fi
# 	cat <<-EOT | install_systemd_unit "${UNIT_NAME}"
# 		[Unit]
# 		Description=BuildKit (Rootless)
# 		PartOf=${SYSTEMD_CONTAINERD_UNIT}

# 		[Service]
# 		Environment=PATH=$BIN:/sbin:/usr/sbin:$PATH
# 		ExecStart="$REALPATH0" nsenter -- buildkitd ${BUILDKITD_FLAG}
# 		ExecReload=/bin/kill -s HUP \$MAINPID
# 		RestartSec=2
# 		Restart=always
# 		Type=simple
# 		KillMode=mixed

# 		[Install]
# 		WantedBy=default.target
# 	EOT
# }
