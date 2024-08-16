{ flake, pkgs, config, ... }:
let
  vscode_extensions = flake.inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace;
in
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
      direnv = {
        restart.automatic = true;
        path.executable = "${config.home.profileDirectory}/bin/direnv";
      };
      treefmt = {
        command = "${pkgs.treefmt2}/bin/treefmt";
      };
      gitlab = {
        aiAssistedCodeSuggestions.enabled = false;
        duo.enabledWithoutGitlabProject = false;
      };
    };
    mutableExtensionsDir = false;

    extensions = with vscode_extensions; [
      bbenoist.nix
      jnoortheen.nix-ide
      mkhl.direnv
      ms-python.python
      mhutchie.git-graph
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons
      tamasfe.even-better-toml
      # ms-azuretools.vscode-docker # not helpful if we're using podman
      ibecker.treefmt-vscode
      gitlab.gitlab-workflow
    ];
  };
}
