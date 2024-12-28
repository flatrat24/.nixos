{ pkgs, lib, config, ... }:
let
  cfg = config.neovim.plugins.lsp.languages.bash;
in {
  options = {
    neovim.plugins.lsp.languages.bash = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.plugins.lsp.enable;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      plugins.lsp.servers.bashls = {
        enable = true;
        autostart = true;
        filetypes = [ "sh" ];
      };
    };
  };
}
