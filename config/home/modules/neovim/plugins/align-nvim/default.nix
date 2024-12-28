{ pkgs, lib, config, ... }:
let
  align-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "align-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "Vonr";
      repo = "align.nvim";
      rev = "12ed24b34df81d57e777fea5a535611bab10a620";
      hash = "sha256-z8+lEs8bQS4Gz3cgQQ5Cb3oW58Et7it/tAxUtE3cLc4=";
    };
  };
in {
  options = {
    neovim.plugins.align-nvim = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.enable;
      };
    };
  };

  config = lib.mkIf config.neovim.plugins.align-nvim.enable (lib.mkMerge [
    {
      programs.nixvim = {
        extraPlugins = [
          align-nvim
        ];
        extraConfigLua = ''
          ---## Keymaps ##---
          vim.keymap.set('x', 'aa',function()
            require'align'.align_to_char({length = 1,                                                                                                                                })
          end,                                                                                { noremap = true, silent = true,            desc = "Align to Single Character"           })
          
          vim.keymap.set('x', 'ad', function()
            require'align'.align_to_char({preview = true, length = 2,                                                                                                                  })
          end,                                                                                { noremap = true, silent = true,            desc = "Align to Two Characters"             })
          
          -- Aligns to a string with previews
          vim.keymap.set('x', 'aw', function()
              require'align'.align_to_string({preview = true, regex = false,                                                                                                           })
          end,                                                                                { noremap = true, silent = true,            desc = "Align to a String"                   })
          
          -- Aligns to a Vim regex with previews
          vim.keymap.set('x', 'ar', function()
              require'align'.align_to_string({preview = true, regex = true,                                                                                                            })
          end,                                                                                { noremap = true, silent = true,            desc = "Align to a Regex Pattern"            })
          
          -- Example gawip to align a paragraph to a string with previews
          vim.keymap.set('n', 'gaw', function()
              local a = require'align'
              a.operator(a.align_to_string, {regex = false, preview = true,                                                                                                            })
          end,                                                                                { noremap = true, silent = true,            desc = "Align Paragraph to a String"         })
          
          -- Example gaaip to align a paragraph to 1 character
          vim.keymap.set('n', 'gaa', function()
              local a = require'align'
              a.operator(a.align_to_char)
          end,                                                                                { noremap = true, silent = true,            desc = "Align Paragraph to Single Character" })
        '';
      };
    }
  ]);
}
