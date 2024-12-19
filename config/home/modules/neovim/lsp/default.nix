{ pkgs, lib, config, ... }: {
  imports = [
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

  config = lib.mkIf config.neovim.plugins.lsp.enable (lib.mkMerge [
    {
      programs.nixvim = {
        plugins.lsp = {
          enable = true;
          inlayHints = true;
        };
      };
    }
  ]);
}
