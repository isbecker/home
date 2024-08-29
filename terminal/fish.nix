{ flake, pkgs, ... }:
{
  programs.fish = {
    enable = true;
    loginShellInit = ''
      set -gx NIX_PATH $HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/$USER/channels $NIX_PATH
      set -gx PATH $PATH $HOME/.local/bin /usr/local/go/bin
    '';

    interactiveShellInit = ''
      fzf_configure_bindings --directory=\cf
      jira completion fish | source
    '';

    plugins = [
      { name = "bass"; src = pkgs.fishPlugins.bass.src; }
      { name = "forgit"; src = pkgs.fishPlugins.forgit.src; }
      {
        # nix-prefetch-github --rev v10.2 PatrickF1 fzf.fish
        name = "fzf.fish";
        src = pkgs.fetchFromGitHub {
          owner = "PatrickF1";
          repo = "fzf.fish";
          rev = "85503fbc4b6026c616dd5dc8ebb4cfb82e1ef16c"; # v10.2
          sha256 = "sha256-1/MLKkUHe4c9YLDrH+cnL+pLiSOSERbIZSM4FTG3wF0=";
        };
      }
    ];
    functions = {
      fzf = {
        body =
          ''
            if set --query TMUX
              fzf-tmux $argv
            else
              command fzf $argv
            end
          '';
        wraps = "fzf";
        description = "Use fzf-tmux if in tmux session";
      };
      update_aws_config = {
        body = ''
          aws configure sso --profile $AWS_PROFILE
        '';
      };
      aws_sso_login = {
        body = ''
          aws sso login --profile $AWS_PROFILE
        '';
      };
      update_eks_kubeconfig = {
        body = ''
          # Query AWS to get the cluster name for the profile
          set cluster_name (aws eks list-clusters --profile $AWS_PROFILE --query "clusters[0]" --output text)

          # Check if cluster name is obtained
          if test -n "$cluster_name"
            aws eks update-kubeconfig --name $cluster_name --profile $AWS_PROFILE --kubeconfig $KUBECONFIG
          else
            echo "No EKS cluster found for profile $AWS_PROFILE"
          end
        '';
      };
      vault_login = {
        body = ''
          set -gx VAULT_ADDR "https://vault.infra.$VAULT_ENV.gov.he2pi.com/"
          set -gx VAULT_TOKEN (vault login -format=json -method=oidc -path=$VAULT_PATH role=$VAULT_ROLE | jq -r '.auth.client_token')
        '';
      };
      vault_config = {
        body = ''
          argparse 'h/help' 'e/env=' 'r/role=' 'p/path=' -- $argv
          or return

          if set -ql _flag_help
            echo "vault_config [-e|--env] [-r|--role] [-p|--path]"
          end
          
          if set -ql _flag_env
            set -gx VAULT_ENV $_flag_env
          end
          if set -ql _flag_role
            set -gx VAULT_ROLE $_flag_role
          end
          if set -ql _flag_path
            set -gx VAULT_PATH $_flag_path
          end
        '';
      };
    };
  };

}
