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
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                  return
                end

                return { timeout_ms = 500, bufnr = bufnr }
              end
            '';
          format_after_save = # Lua
            ''
              function(bufnr)
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                  return
                end

                return { async = true, bufnr = bufnr }
              end
            '';
          log_level = "info";
          notify_on_error = true;
          notify_no_formatters = true;
          formatters = {
            treefmt = {
              command = lib.getExe pkgs.treefmt2;
              stdin = true;
              args = [ "--stdin" "$FILENAME" ];
            };
          };
        };
    };

    keymaps = [
      {
        mode = "";
        key = "<leader>I";
        action.__raw = ''
          function()
            require('conform').format { async = true, lsp_fallback = true }
          end
        '';
        options = {
          desc = "[f]ormat buffer";
        };
      }
    ];
  };
}

