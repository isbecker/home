{ flake, pkgs, ... }:

let
  inherit (flake.config) me;
in
{
  programs.jujutsu = {
    enable = true;
    ediff = false;
    settings = {
      user = {
        email = me.email;
        name = me.fullname;
        ui = {
          editor = "nvim";
        };
      };
    };
  };
  home.packages = with pkgs; [
    jjui
    lazyjj
    gg-jj
  ];
}
