{ flake, pkgs, config, ... }:
{
  programs.vscode = {
    enable = true;
    #package = (config.lib.nixGL.wrappers.nvidiaPrime pkgs.vscode);
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
          defaultProfile.linux = "tmux";
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
      treefmt = {
        command = "${pkgs.treefmt}/bin/treefmt";
      };
      gitlens = { };
    };
    mutableExtensionsDir = false;

    extensions = with flake.inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace;
      with flake.inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace-release; [

        github.copilot
        github.copilot-chat

        # asvetliakov.vscode-neovim
        activitywatch.aw-watcher-vscode

        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons

        bierner.github-markdown-preview

        ibecker.treefmt-vscode
        bbenoist.nix
        jnoortheen.nix-ide
        mkhl.direnv
        ms-python.python
        hashicorp.terraform
        redhat.vscode-yaml
        tamasfe.even-better-toml

        gitlab.gitlab-workflow
        # mhutchie.git-graph
        eamodio.gitlens

        foam.foam-vscode

        tim-koehler.helm-intellisense

        upboundio.upbound
        kcl.kcl-vscode-extension
      ];
  };
}
