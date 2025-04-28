{ pkgs, lib, config, ... }:
let
  cfg = config.neovim.plugins.lsp.languages.cpp;
in {
  options = {
    neovim.plugins.lsp.languages.cpp = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.plugins.lsp.enable;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      plugins.lsp.servers.clangd = {
        enable = true;
        autostart = true;
        filetypes = [ "cpp" ];
      };
    };
  };
}
