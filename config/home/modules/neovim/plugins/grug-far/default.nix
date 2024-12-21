{ pkgs, lib, config, ... }: {
  options = {
    neovim.plugins.grug-far = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.enable;
      };
    };
  };

  config = lib.mkIf config.neovim.plugins.grug-far.enable {
    programs.nixvim = {
      extraPlugins = with pkgs.vimPlugins; [
        grug-far-nvim
      ];
      extraConfigLua = ''
        require('grug-far').setup({
          keymaps = {
            replace = { n = '<localleader>r' },
            qflist = { n = '<localleader>q' },
            syncLocations = { n = '<localleader>s' },
            syncLine = { n = '<localleader>l' },
            close = { n = '<localleader>c' },
            historyOpen = { n = '<localleader>t' },
            historyAdd = { n = '<localleader>a' },
            refresh = { n = '<localleader>f' },
            openLocation = { n = '<localleader>o' },
            openNextLocation = { n = '<down>' },
            openPrevLocation = { n = '<up>' },
            gotoLocation = { n = '<enter>' },
            pickHistoryEntry = { n = '<enter>' },
            abort = { n = '<localleader>b' },
            help = { n = 'g?' },
            toggleShowCommand = { n = '<localleader>p' },
            swapEngine = { n = '<localleader>e' },
            previewLocation = { n = '<localleader>i' },
            swapReplacementInterpreter = { n = '<localleader>x' },
            applyNext = { n = '<localleader>j' },
            applyPrev = { n = '<localleader>k' },
          },
        })
      '';
      keymaps = [
        { mode = [ "n" ]; key = "<leader>vg"; action = "<cmd>GrugFar<CR>"; options = { noremap = true; silent = true; desc = "View Find and Replace"; }; }
      ];
    };
  };
}
