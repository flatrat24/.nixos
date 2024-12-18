{ pkgs, lib, config, ... }: {
  options = {
    neovim.plugins.neoscroll = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.enable;
      };
    };
  };

  config = lib.mkIf config.neovim.plugins.neoscroll.enable {
    programs.nixvim = {
      plugins.neoscroll = {
        enable = true;
        settings = {
          mappings = [
            "<C-u>"
            "<C-d>"
            "<C-b>"
            "<C-f>"
            "<C-y>"
            "<C-e>"
            "zt"
            "zz"
            "zb"
          ];
          hide_cursor = true;
          stop_eof = true;
          respect_scrolloff = false;
          cursor_scrolls_alone = true;
          duration_multiplier = 0.1;
          easing = "linear";
          pre_hook = null;
          post_hook = null;
          performance_mode = false;
          ignored_events = [
            "WinScrolled"
            "CursorMoved"
          ];
        };
      };
    };
  };
}
