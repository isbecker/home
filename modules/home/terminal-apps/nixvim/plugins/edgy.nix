{
  programs.nixvim.plugins = {
    edgy = {
      # Disabled because edgy is buggy with sizing and nixvim
      # I think that the nxivim setting for size is wrong
      # because it expects an integer value only but 
      # according to edgy, it is like { size: { height: 0.4 } }
      # so then when nvim loads, there are like 1000x error
      # messages.
      # Cool idea for addon, but I don't think I can use it 
      # with the nixvim plugin. Maybe raw - with packer...
      enable = false;
      # settings = {
      #   animate = {
      #     enabled = true;
      #   };
      #   # bottom = [
      #   #   {
      #   #     filter = ''
      #   #       function(buf, win)
      #   #       		return vim.api.nvim_win_get_config(win).relative == ""
      #   #       end
      #   #     '';
      #   #     ft = "toggleterm";
      #   #     size = 30;
      #   #   }
      #   #   {
      #   #     filter = ''
      #   #       function(buf)
      #   #       		return vim.bo[buf].buftype == "help"
      #   #       end
      #   #     '';
      #   #     ft = "help";
      #   #     size = 20;
      #   #   }
      #   # ];
      #   left = [
      #     {
      #       title = "Neo-Tree";
      #       ft = "neo-tree";
      #       filter = ''
      #         function(buf)
      #           return vim.b[buf].neo_tree_source == "filesystem"
      #         end
      #       '';
      #       size = 30;
      #     }
      #     {
      #       title = "Neo-Tree Git";
      #       ft = "neo-tree";
      #       filter = ''
      #         function(buf)
      #           return vim.b[buf].neo_tree_source == "git_status"
      #         end
      #       '';
      #       pinned = true;
      #       # collapsed = true;
      #       open = "Neotree position=right git_status";
      #     }
      #     {
      #       title = "Neo-Tree Buffers";
      #       ft = "neo-tree";
      #       filter = ''
      #         function(buf)
      #           return vim.b[buf].neo_tree_source == "buffers"
      #         end
      #       '';
      #       pinned = true;
      #       # collapsed = true;
      #       open = "Neotree position=top buffers";
      #     }
      #     # {
      #     #   # title = ''
      #     #   #   function()
      #     #   #     local buf_name = vim.api.nvim_buf_get_name(0) or "[No Name]"
      #     #   #       return vim.fn.fnamemodify(buf_name, ":t")
      #     #   #     end
      #     #   # '';
      #     #   ft = "Outline";
      #     #   pinned = true;
      #     #   open = "SymbolsOutlineOpen";
      #     # }
      #   ];
      #   # wo = {
      #   #   signcolumn = "no";
      #   #   spell = false;
      #   #   winbar = false;
      #   #   winfixheight = false;
      #   #   winfixwidth = false;
      #   #   winhighlight = "";
      #   # };
      # };
    };
  };
}
