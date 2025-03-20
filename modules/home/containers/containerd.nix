{ pkgs, ... }:
{
  virtualisation = {
    containerd.rootless = {
      enable = true;
      nixSnapshotterIntegration = false;
      gVisorIntegration = false;
      setNamespace = "default";
      path = [
        "/usr"
        # "${pkgs.shadow}"
      ];
    };
  };
  services.nix-snapshotter.rootless = {
    enable = false;
  };
  home.packages = with pkgs; [
    nerdctl
  ];
}
