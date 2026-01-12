{ pkgs, flake, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    inputs.krewfile.homeManagerModules.krewfile
  ];
  programs.krewfile = {
    enable = true;
    krewPackage = pkgs.krew;
    indexes = {
      pickdeep = "https://github.com/flavono123/flew-index.git";
    };
    plugins = [
      "explore"
      "gadget"
      "modify-secret"
      "neat"
      "oidc-login"
      "pv-migrate"
      "stern"
      "view-secret"
      "warp"

      "pickdeep"
    ];
  };
}
