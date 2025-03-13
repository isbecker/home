{
  imports = [
    # ./buildkit.nix
    # ./containerd.nix
    ./lazydocker.nix
    ./podman.nix
    # services running with services.podman.containers
    ./freshrss.nix
    ./ollama.nix
    ./open-webui.nix
  ];
}
