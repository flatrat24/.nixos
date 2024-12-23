{ pkgs, lib, config, ... }: {
  options = {
    neovim.plugins.lsp.languages.bash = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.plugins.lsp.enable;
      };
    };
  };

  config = lib.mkIf config.neovim.plugins.lsp.languages.bash.enable {
    programs.nixvim = {
      plugins.lsp.servers.bashls = {
        enable = true;
        autostart = true;
        # cmd = [ "nixd" ];
        filetypes = [ "sh" ];
      };
    };
  };
}
