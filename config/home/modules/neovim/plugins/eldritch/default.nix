{ pkgs, lib, config, ... }:
let
  cfg = config.neovim.plugins.eldritch;
  eldritch-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "eldritch-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "eldritch-theme";
      repo = "eldritch.nvim";
      rev = "1d97e9759e6fa3796fdef71b7ec9d84d277e4f16";
      hash = "sha256-5mOhtJQ+vHp+ivy7HKyOfnAkZ02M2J9TM2bTPAd5u9U=";
    };
  };
in {
  options = {
    neovim.plugins.eldritch = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.nixvim.enable;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      extraPlugins = [
        eldritch-nvim
      ];
      # extraConfigLua = ''
      #   vim.cmd[[colorscheme eldritch]]
      # '';
      extraConfigLua = ''
        require("eldritch").setup({})
        require("eldritch").load()
      '';
    };
  };
}
