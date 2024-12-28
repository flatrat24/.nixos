{ pkgs, lib, config, ... }:
let
  cfg = config.neovim.plugins.lsp.languages.nix;
in {
  options = {
    neovim.plugins.lsp.languages.nix = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.plugins.lsp.enable;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      plugins.lsp.servers.nixd = {
        enable = true;
        autostart = true;
        cmd = [ "nixd" ];
        filetypes = [ "nix" ];
      };
    };
  };
}
