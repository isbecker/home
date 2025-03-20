{ flake, pkgs, ... }:
{
  programs.nixvim = {
    extraPlugins = [
      {
        plugin = pkgs.vimUtils.buildVimPlugin {
          pname = "vim-autoread";
          version = "unstable";
          src = flake.inputs.vim-autoread;
        };
        config = ''
          autocmd VimEnter * nested WatchForChangesAllFile!
        '';
      }
    ];
  };
}
