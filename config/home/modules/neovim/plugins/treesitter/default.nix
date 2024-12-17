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

          grammarPackages = with pkgs.vimPlugins.nvim-treesitter-parsers; [
            bash
            c
            cpp
            css
            html
            hyprlang
            json
            kdl
            lua
            markdown
            markdown_inline
            nix
            python
            query
            rasi
            vim
            vimdoc
            yaml
          ];

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
