{
  programs.nixvim.plugins = {
    cmp = {
      enable = true;
      autoEnableSources = true;
      settings = {
        experimental = { ghost_text = true; };
        sources = [
          # { name = "cmp_ai"; }
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
          # "<C-x>" = "cmp.mapping(cmp.mapping.complete({config = {sources = cmp.config.sources({{ name = 'cmp_ai' }})}}), { 'i' })";
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
    # cmp-ai = {
    #   enable = true;
    #   settings = {
    #     ignored_file_types = { };
    #     max_lines = 1000;
    #     notify = true;
    #     notify_callback = ''
    #       function(msg)
    #         vim.notify(msg)
    #       end
    #     '';
    #     provider = "Ollama";
    #     # provider_options = ''
    #     #   model = 'deepseek-coder',
    #     #   prompt = function(lines_before, lines_after)
    #     #     -- You may include filetype and/or other project-wise context in this string as well.
    #     #     -- Consult model documentation in case there are special tokens for this.
    #     #       return "<｜fim▁begin｜>" .. lines_before .. "<｜fim▁hole｜>" .. lines_after .. "<｜fim▁end｜>"
    #     #   end
    #     # '';
    #     provider_options = {
    #       model = "deepseek-coder";
    #       # prompt = ''
    #       #   function(lines_before, lines_after)
    #       #     -- You may include filetype and/or other project-wise context in this string as well.
    #       #     -- Consult model documentation in case there are special tokens for this.
    #       #     return "<｜fim▁begin｜>" .. lines_before .. "<｜fim▁hole｜>" .. lines_after .. "<｜fim▁end｜>"
    #       #   end
    #       # '';
    #       auto_unload = false; # Set to true to automatically unload the model when exiting nvim.
    #     };
    #
    #     run_on_every_keystroke = true;
    #   };
    # };
  };
}
