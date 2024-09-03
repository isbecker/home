{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kubectl
    kustomize
    crossplane-cli
    argocd
    kubernetes-helm
    cue
    kyverno-chainsaw
    kind
    # k3d
  ];


}
