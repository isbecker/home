{ flake, lib, ... }:
{
    programs.starship = {
        enable = true;
        enableFishIntegration = true;
        settings = {
            # format = lib.concatStrings [
            #     "$username"
            #     "$hostname"
            #     "$shlvl"
            #     "$kubernetes"
            #     "$directory"
            #     "$git_branch"
            #     "$git_commit"
            #     "$git_state"
            #     "$git_status"
            #     "$time"
            #     "$cmd_duration"
            #     "$line_break"
            #     ❯ 
            # ];
        };
    };
}