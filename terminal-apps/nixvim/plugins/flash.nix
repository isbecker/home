{ config, ... }:
let
  helpers = config.lib.nixvim;
in
{
  programs.nixvim = {
    plugins.flash.enable = true;
    keymaps = [
      {
        key = "s";
        mode = [
          "n"
          "x"
          "o"
        ];
        action = helpers.mkRaw ''function() require("flash").jump() end'';
        options.desc = "Flash";
      }
      {
        key = "S";
        mode = [
          "n"
          "x"
          "o"
        ];
        action = helpers.mkRaw ''function() require("flash").treesitter() end'';
        options.desc = "Flash Treesitter";
      }
      {
        key = "r";
        mode = "o";
        action = helpers.mkRaw ''function() require("flash").remote() end'';
        options.desc = "Remote Flash";
      }
      {
        key = "R";
        mode = [
          "o"
          "x"
        ];
        action = helpers.mkRaw ''function() require("flash").treesitter_search() end'';
        options.desc = "Treesitter search";
      }
      {
        key = "<c-s>";
        mode = "c";
        action = helpers.mkRaw ''function() require("flash").toggle() end'';
        options.desc = "Toggle Flash search";
      }
    ];
  };
}
