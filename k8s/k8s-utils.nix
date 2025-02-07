{ pkgs, ... }:
{
  imports = [
    ./vcluster.nix
  ];
  home.packages = with pkgs; [
    kubectl
    kustomize
    kubernetes-helm
    kubectl-view-secret

    crossplane-cli
    argocd
    # kyverno-chainsaw

    cue

    kind
  ];
}
