{ flake, pkgs, ... }:
{
  programs.nixvim.plugins = {
    cmp = {
      enable = true;
      autoEnableSources = true;
      settings = {
        experimental = { ghost_text = true; };
        sources = [
          { name = "git"; }
          { name = "nvim_lsp"; }
          { name = "emoji"; }
          { name = "treesitter"; }
          { name = "cmdline"; }
          {
            name = "buffer"; # text within current buffer
            option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
            keywordLength = 3;
          }
        ];
        window = {
          completion = { border = "solid"; };
          documentation = { border = "solid"; };
        };
        mapping = {
          "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          "<j>" = "cmp.mapping.select_next_item()";
          "<k>" = "cmp.mapping.select_prev_item()";
          "<C-e>" = "cmp.mapping.abort()";
          "<C-b>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete()";
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<S-CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })";
        };
      };

    };
    cmp-nvim-lsp = {
      enable = true;
    };
    cmp-treesitter.enable = true;
    cmp-buffer.enable = true;
    cmp-path.enable = true;
    cmp-cmdline.enable = true;
    cmp-emoji.enable = true;
  };
}
