{ config, pkgs, lib, ... }:
let
  helpers = config.lib.nixvim;
in
{
  programs.nixvim = {
    plugins.conform-nvim = {
      enable = true;
      settings =
        {
          formatters_by_ft = {
            "*" = [ "treefmt" ];
          };
          format_on_save = # Lua
            ''
              function(bufnr)
                -- Disable "format_on_save lsp_fallback" for lanuages that don't
                -- have a well standardized coding style. You can add additional
                -- lanuages here or re-enable it for the disabled ones.
                local disable_filetypes = { c = true, cpp = true }
                return {
                  timeout_ms = 500,
                  lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype]
                }
              end
            '';
          # format_after_save = # Lua
          #   ''
          #     lsp_format = "fallback"
          #   '';
          log_level = "debug";
          notify_on_error = true;
          notify_no_formatters = true;
          formatters = {
            treefmt = {
              command = lib.getExe pkgs.treefmt2;
              stdin = true;
              args = [ "--stdin" ];
            };
          };
        };
    };

    keymaps = [
      {
        mode = "";
        key = "<leader>f";
        action.__raw = ''
          function()
            require('conform').format { async = true, lsp_fallback = true }
          end
        '';
        options = {
          desc = "[F]ormat buffer";
        };
      }
    ];

  };
}

