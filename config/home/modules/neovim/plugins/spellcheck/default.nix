{ pkgs, lib, config, ... }:
let
  cfg = config.neovim.plugins.spellcheck;
  academic-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "academic-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "ficcdaf";
      repo = "academic.nvim";
      rev = "d66c44bd0ecd6791c27debea40268fc9701cef04";
      hash = "sha256-jmPewh6U8tpRTZWKc6uFCFjcwDGbNttcPCPVSzvvO8g=";
    };
  };
  vim-dirtytalk = pkgs.vimUtils.buildVimPlugin {
    name = "vim-dirtytalk";
    src = pkgs.fetchFromGitHub {
      owner = "psliwka";
      repo = "vim-dirtytalk";
      rev = "aa57ba902b04341a04ff97214360f56856493583";
      hash = "sha256-azU5jkv/fD/qDDyCU1bPNXOH6rmbDauG9jDNrtIXc0Y=";
    };
  };
in {
  options = {
    neovim.plugins.spellcheck = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.nixvim.enable;
      };
      academic.enable = lib.mkOption {
        type = lib.types.bool;
        default = cfg.enable;
      };
      programming.enable = lib.mkOption {
        type = lib.types.bool;
        default = cfg.enable;
      };
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      programs.nixvim = {
        extraPlugins = [
          academic-nvim
          vim-dirtytalk
        ];
        opts = {
          spelllang = [ "en_us" ]
            ++ lib.optionals (cfg.academic.enable) [ "en-academic" ]
            ++ lib.optionals (cfg.programming.enable) [ "programming" ]; # :DirtytalkUpdate
        };
      };
    }
    (lib.mkIf cfg.academic.enable { })
    (lib.mkIf cfg.programming.enable { })
  ]);
}
