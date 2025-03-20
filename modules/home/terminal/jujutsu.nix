{ pkgs, ... }:
{
  programs.jujutsu = {
    enable = true;
    ediff = false;
    settings = {
      user = {
        email = "ian.becker@he360.com";
        name = "Ian Becker";
        ui = {
          editor = "nvim";
        };
      };
    };
  };
  home.packages = with pkgs; [
    jjui
    # lazyjj
    # gg-jj
  ];
}
