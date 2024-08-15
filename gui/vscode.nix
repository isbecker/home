{ flake, pkgs, ... }:
{
    programs.vscode = {
        enable = true;
        userSettings = {
          files.autoSave = "afterDelay";
          editor ={
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
        };
        extensions = [
          pkgs.vscode-extensions.bbenoist.nix
          pkgs.vscode-extensions.jnoortheen.nix-ide
          pkgs.vscode-extensions.mkhl.direnv
          pkgs.vscode-extensions.ms-python.python
          pkgs.vscode-extensions.mhutchie.git-graph
          pkgs.vscode-extensions.catppuccin.catppuccin-vsc
          pkgs.vscode-extensions.catppuccin.catppuccin-vsc-icons
          pkgs.vscode-extensions.tamasfe.even-better-toml
          pkgs.vscode-extensions.ms-azuretools.vscode-docker
          pkgs.vscode-extension-gitlab-gitlab-workflow
        ];

    };
}