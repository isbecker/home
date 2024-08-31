{ pkgs, ... }:
{
  home.sessionVariables = {
    KIND_EXPERIMENTAL_PROVIDER = "podman";
  };
  home.packages = with pkgs; [
    kind
  ];
}
