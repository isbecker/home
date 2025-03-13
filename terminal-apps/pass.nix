{ pkgs, ... }:
{
  programs.password-store = {
    enable = true;
    package = pkgs.pass.withExtensions (exts: [ exts.pass-update ]);
  };
  home.packages = with pkgs; [
    pass-git-helper
  ];
}
