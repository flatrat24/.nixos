{ lib, config, ... }:
let
  cfg = config.neovim.plugins.lsp;
in {
  imports = [
    ./bash
    ./c
    ./cpp
    ./nix
  ];

  options = {
    neovim.plugins.lsp = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.enable;
      };
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      programs.nixvim = {
        plugins.lsp = {
          enable = true;
          inlayHints = true;
        };
      };
    }
    (lib.mkIf config.neovim.plugins.cmp.enable {
      programs.nixvim = {
        plugins.cmp.settings.sources = [
          { name = "nvim_lsp"; }
        ];
      };
    })
  ]);
}
