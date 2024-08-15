{ flake, pkgs, ... }:
{
    programs.vscode = {
        enable = true;
        enableUpdateCheck = false;
        enableExtensionUpdateCheck = false;
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
          git = {
            confirmSync = false;
          };
        };
        mutableExtensionsDir = false;

        extensions = with pkgs.vscode-extensions; [
          bbenoist.nix
          jnoortheen.nix-ide
          mkhl.direnv
          ms-python.python
          mhutchie.git-graph
          catppuccin.catppuccin-vsc
          catppuccin.catppuccin-vsc-icons
          tamasfe.even-better-toml
          ms-azuretools.vscode-docker
        ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "treefmt-vscode";
            publisher = "ibecker";
            version = "2.0.5";
            sha256 = "sha256-LEyUCkrVIsEc5FB2n7cVWD1viQFVNCtEMwBNEmI8RGo=";
          }
        ];
    };
}