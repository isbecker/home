{ flake, pkgs, config, ... }:
{
  programs.vscode = {
    enable = true;
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
      workbench = {
        colorTheme = "Catppuccin Macchiato";
        iconTheme = "catppuccin-macchiato";
      };
      explorer.confirmDragAndDrop = false;
      diffEditor.ignoreTrimWhitespace = false;
      git = {
        confirmSync = false;
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
        command = "${pkgs.treefmt2}/bin/treefmt";
      };
      gitlab = {
        aiAssistedCodeSuggestions.enabled = false;
        duo.enabledWithoutGitlabProject = false;
      };
      gitlens = {
        remotes = [
          {
            domain = "cm.infra.he2pi.com";
            type = "GitLab";
          }
        ];
        autolinks = [
          {
            prefix = "INF-";
            url = "https://jira.corp.he2pi.com/browse/INF-<num>";
          }
        ];
      };
    };
    mutableExtensionsDir = false;

    extensions = with flake.inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace;
      with flake.inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace-release; [
        bbenoist.nix
        jnoortheen.nix-ide
        mkhl.direnv
        ms-python.python
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons
        # ms-azuretools.vscode-docker # not helpful if we're using podman
        ibecker.treefmt-vscode

        hashicorp.terraform
        redhat.vscode-yaml
        tamasfe.even-better-toml

        gitlab.gitlab-workflow

        mhutchie.git-graph
        eamodio.gitlens
      ];
  };
}
