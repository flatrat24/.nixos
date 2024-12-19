{ pkgs, lib, config, ... }: {
  options = {
    neovim.plugins.lsp.languages.nix = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.plugins.lsp.enable;
      };
    };
  };

  config = lib.mkIf config.neovim.plugins.lsp.languages.nix.enable {
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
