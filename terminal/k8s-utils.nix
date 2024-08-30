{ pkgs, ... }:
{
  home.packages = with pkgs; [
    cue
    kyverno-chainsaw
  ];
}