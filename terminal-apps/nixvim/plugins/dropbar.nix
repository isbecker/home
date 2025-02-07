{
  programs.nixvim = {
    plugins.dropbar = {
      enable = false; # dropbar has a winbar that messes up both noice and neo-tree
      settings = {
        bar = {
          enable = true;
          sources = {
            __raw = ''
              function(buf, _)
                local sources = require('dropbar.sources')
                return {
                  require('dropbar.utils').source.fallback({
                    sources.lsp,
                    sources.treesitter,
                    sources.markdown,
                  })
                }
              end
            '';
          };
        };
        menu = {
          keymaps = {
            h = "<C-w>q";
            l = {
              __raw = ''
                function()
                  local dropbar = require('dropbar')
                  local utils = require('dropbar.utils')
                  local menu = utils.menu.get_current()
                  if not menu then
                    return
                  end
                  local cursor = vim.api.nvim_win_get_cursor(menu.win)
                  local component = menu.entries[cursor[1]]:first_clickable(cursor[2])
                  if component then
                    menu:click_on(component, nil, 1, 'l')
                  end
                end
              '';
            };
          };
        };
      };
    };
  };
}
