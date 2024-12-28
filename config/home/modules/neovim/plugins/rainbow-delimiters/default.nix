{ pkgs, lib, config, ... }:
let
  cfg = config.neovim.plugins.rainbow-delimiters;
in {
  options = {
    neovim.plugins.rainbow-delimiters = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.nixvim.enable;
      };
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      programs.nixvim = {
        plugins.rainbow-delimiters = {
          enable = true;
        };
        # TODO: Make this linked to the current theme type
        extraConfigLua = ''
          vim.cmd[[
            highlight RainbowDelimiterRed    guifg=#F38BA8 ctermfg=White
            highlight RainbowDelimiterYellow guifg=#F9E2AF ctermfg=White
            highlight RainbowDelimiterBlue   guifg=#89B4FA ctermfg=White
            highlight RainbowDelimiterOrange guifg=#FAB387 ctermfg=White
            highlight RainbowDelimiterGreen  guifg=#A6E3A1 ctermfg=White
            highlight RainbowDelimiterViolet guifg=#B4BEFE ctermfg=White
            highlight RainbowDelimiterCyan   guifg=#94E2D5 ctermfg=White
          ]]
        '';
      };
    }
  ]);
}
