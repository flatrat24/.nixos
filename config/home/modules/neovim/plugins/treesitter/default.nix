{ pkgs, lib, config, ... }: {
  options = {
    neovim.plugins.treesitter = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.enable;
      };
    };
  };

  config = lib.mkIf config.neovim.plugins.treesitter.enable (lib.mkMerge [
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
  ]);
}
