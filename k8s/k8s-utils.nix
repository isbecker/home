{ pkgs, ... }:
{
  imports = [
    ./vcluster.nix
  ];
  home.packages = with pkgs; [
    kubectl
    kustomize
    kubernetes-helm

    crossplane-cli
    argocd
    # kyverno-chainsaw

    cue

    kind
  ];
}
