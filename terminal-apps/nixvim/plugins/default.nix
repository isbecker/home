{ lib, ... }:
let
  # Combine mapAttrs' and filterAttrs
  #
  # f can return null if the attribute should be filtered out.
  mapAttrsMaybe = f: attrs:
    lib.pipe attrs [
      (lib.mapAttrsToList f)
      (builtins.filter (x: x != null))
      builtins.listToAttrs
    ];
  forAllNixFiles = dir: f:
    if builtins.pathExists dir then
      lib.pipe dir [
        builtins.readDir
        (mapAttrsMaybe (fn: type:
          if type == "regular" then
          # let name = lib.removeSuffix ".nix" fn; in
            lib.nameValuePair fn
              (
                f (builtins.path {
                  path = "${dir}/${fn}";
                  name = "short-${lib.removeSuffix ".nix" fn}";
                })
              )
          else if type == "directory" && builtins.pathExists "${dir}/${fn}/default.nix" then
            lib.nameValuePair fn (f "${dir}/${fn}")
          else
            null
        ))
      ] else { };
  plugins = forAllNixFiles ./.
    (fn: import fn);
in
{
  # imports = lib.attrValues plugins;
  imports = [
    ./airline.nix # Disabled
    ./auto-session.nix
    ./autoread.nix
    ./autosave.nix
    ./barbar.nix
    ./barbecue.nix
    ./cmp.nix
    ./codecompanion.nix
    ./conform.nix
    ./cursorline.nix
    ./dadbod.nix
    ./diffview.nix
    ./dropbar.nix # Disabled
    ./edgy.nix # Disabled
    ./filetypes.nix
    ./firenvim.nix # Disabled
    ./flash.nix
    ./git.nix
    ./gitlab.nix
    ./helm.nix
    ./inc-rename.nix
    ./indent.nix
    ./lastplace.nix
    ./lsp.nix
    ./lualine.nix
    ./mini.nix
    ./neogit.nix
    ./neotree.nix
    ./noice.nix
    ./nvim-surround.nix
    ./persistence.nix # Disabled
    ./rainbow.nix
    ./schemastore.nix
    ./smear-cursor.nix
    ./telescope.nix
    ./toggleterm.nix
    ./treesitter.nix
    ./trouble.nix
    ./twilight.nix
    ./which-key.nix
    ./zen-mode.nix

    ./packer
  ];

  programs.nixvim.plugins = {
    direnv.enable = true;
    nui.enable = true;
    notify.enable = true;
    comment.enable = true;
    dashboard.enable = true;
  };

}



