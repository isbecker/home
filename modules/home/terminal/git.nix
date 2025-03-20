{ flake, pkgs, config, ... }:

let
  inherit (flake) inputs;
  inherit (inputs) self;
  inherit (flake.config) me;
in
{
  programs.git = {
    enable = true;
    userEmail = me.email;
    userName = me.fullname;
    extraConfig = {
      init.defaultBranch = "main";
      # user.signingKey = "";
      # commit.gpgsign = true;
      rerere.enabled = true;
      fetch = {
        auto = 1;
        prune = true;
      };
      # pass-git-helper can marshal to git
      #credential = {
      #  helper = "${pkgs.pass-git-helper}/bin/pass-git-helper";
      #};
    };
    # alternative directory and email can be set up like this
    # includes = [
    #   {
    #     contents = {
    #       user = {
    #         email = me.email;
    #         name = me.fullname;
    #         signingKey = "";
    #       };
    #     };
    #     condition = "gitdir:${config.home.homeDirectory}/play/**";
    #   }
    # ];
  };
  home.packages = with pkgs; [
    git-absorb
  ];
}
