{ flake, pkgs, config, ... }:
{
  programs.vscode = {
    enable = true;
    # package = pkgs.vscode-fhs;
    #package = (config.lib.nixGL.wrappers.nvidiaPrime pkgs.vscode);
    profiles = {
      default = {
        enableUpdateCheck = false;
        enableExtensionUpdateCheck = false;
        userSettings = {
          files.autoSave = "afterDelay";
          editor = {
            formatOnSave = true;
            defaultFormatter = "ibecker.treefmt-vscode";
            fontFamily = "'Iosevka Nerd Font Mono', 'monospace', monospace";
            fontLigatures = true;
          };
          terminal = {
            integrated = {
              fontFamily = "'IosevkaTerm Nerd Font Mono', 'monospace', monospace";
              # defaultProfile.linux = "tmux";
            };
          };
          workbench = {
            colorTheme = "Catppuccin Macchiato";
            iconTheme = "catppuccin-macchiato";
          };
          explorer.confirmDragAndDrop = false;
          diffEditor.ignoreTrimWhitespace = false;
          git = {
            confirmSync = false;
            autofetch = true;
            autofetchPeriod = 180;
            rememberPostCommitCommand = true;
          };
          catppuccin = {
            accentColor = "lavender";
            extraBordersEnabled = true;
          };
          nix = {
            enableLanguageServer = true;
            serverPath = "${pkgs.nil}/bin/nil";
            formatterPath = "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt";
          };
          direnv = {
            path.executable = "${config.home.profileDirectory}/bin/direnv";
          };
          # treefmt = {
          #   command = "${pkgs.treefmt}/bin/treefmt";
          # };
          # gitlens = { };

          # mcp = {
          #   inputs = [
          #     {
          #       type = "promptString";
          #       id = "github_token";
          #       description = "GitHub Personal Access Token";
          #       password = true;
          #     }
          #   ];
          #   servers = {
          #     time = {
          #       command = "uvx";
          #       args = [ "mcp-server-time" ];
          #     };
          #     fetch = {
          #       command = "uvx";
          #       args = [ "mcp-server-fetch" ];
          #     };
          #     github = {
          #       command = "docker";
          #       args = [
          #         "run"
          #         "-i"
          #         "--rm"
          #         "-e"
          #         "GITHUB_PERSONAL_ACCESS_TOKEN"
          #         "ghcr.io/github/github-mcp-server"
          #       ];
          #       env = {
          #         GITHUB_PERSONAL_ACCESS_TOKEN = "''${input:github_token}";
          #       };
          #     };
          #     cloudflare = {
          #       command = "npx";
          #       args = [
          #         "mcp-remote"
          #         "https://observability.mcp.cloudflare.com/sse"
          #       ];
          #     };
          #   };
          # };
        };

        extensions = with flake.inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace;
          with flake.inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace-release; [

            github.vscode-pull-request-github
            github.copilot
            github.copilot-chat

            # asvetliakov.vscode-neovim
            activitywatch.aw-watcher-vscode

            catppuccin.catppuccin-vsc
            # catppuccin.catppuccin-vsc-icons

            bierner.github-markdown-preview

            ibecker.treefmt-vscode
            bbenoist.nix
            jnoortheen.nix-ide
            mkhl.direnv
            ms-python.python
            redhat.vscode-yaml
            tamasfe.even-better-toml

            # gitlab.gitlab-workflow
            mhutchie.git-graph
            eamodio.gitlens

            foam.foam-vscode

            tim-koehler.helm-intellisense

            upboundio.upbound
            kcl.kcl-vscode-extension

            nefrob.vscode-just-syntax
          ];
      };
    };
  };
}
