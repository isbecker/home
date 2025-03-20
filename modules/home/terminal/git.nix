{ flake, pkgs, config, ... }:
{
  programs.git = {
    enable = true;
    userEmail = "ian@beckr.dev";
    userName = "Ian Becker";
    extraConfig = {
      init.defaultBranch = "main";
      #user.signingKey = "";
      #commit.gpgsign = true;
      rerere.enabled = true;
      fetch = {
        auto = 1;
        prune = true;
      };
      #credential = {
      #  helper = "${pkgs.pass-git-helper}/bin/pass-git-helper";
      #};
    };
    includes = [
      {
        contents = {
          user = {
            email = "ian@beckr.dev";
            name = "Ian Becker";
            signingKey = "";
          };
        };
        condition = "gitdir:${config.home.homeDirectory}/play/**";
      }
    ];
  };
  home.packages = with pkgs; [
    git-absorb
  ];
}
