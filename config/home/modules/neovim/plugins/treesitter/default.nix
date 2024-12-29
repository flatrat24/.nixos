{ pkgs, lib, config, ... }:
let
  cfg = config.neovim.plugins.treesitter;
in {
  options = {
    neovim.plugins.treesitter = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.nixvim.enable;
      };
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      programs.nixvim = {
        plugins.treesitter = {
          enable = true;

          grammarPackages = pkgs.vimPlugins.nvim-treesitter.allGrammars;

          settings = {
            auto_install = false;
            highlight.enable = true;
            indent.enable = true;
          };
        };
      };
    }
    (lib.mkIf config.latex.enable {
      programs.nixvim.plugins.treesitter.settings = {
        highlight = {
          disable = [
            "latex"
          ];
        };
      };
    })
    (lib.mkIf config.neovim.plugins.illuminate.enable {
      programs.nixvim.plugins.illuminate = {
        providers = [ "treesitter" ];
      };
    })
  ]);
}
