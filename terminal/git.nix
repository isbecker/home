{ flake, pkgs, ... }:
{
    programs.git = {
        enable = true;
        userEmail = "ian.becker@he360.com";
        userName = "Ian Becker";
        extraConfig = {
            init.defaultBranch = "main";
            user.signingKey = "6173020131013ADB";
            commit.gpgsign = true;
            url = {
                "ssh://git@cm.infra.he2pi.com" = {
                    insteadOf = "https://cm.infra.he2pi.com";
                };
            };
            credential = {
                helper = "${pkgs.pass-git-helper}/bin/pass-git-helper";
            };
            credential."cm.infra.he2pi.com" = {
                username = "ian.becker";
            };
        };
    };
}