{ flake, pkgs, ... }:

let
  #inherit (flake.config) me;
in
{
  programs.jujutsu = {
    enable = true;
    ediff = false;
    settings = {
      user = {
        email = "ian@beckr.dev";#me.email;
        name = "Ian Becker";#me.fullname;
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
