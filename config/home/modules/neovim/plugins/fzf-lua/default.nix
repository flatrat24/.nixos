{ pkgs, lib, config, ... }:
let
  cfg = config.neovim.plugins.fzf-lua;
  dependencies = with pkgs; [ ripgrep ];
in {
  options = {
    neovim.plugins.fzf-lua = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.nixvim.enable;
      };
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      programs.nixvim = {
        plugins.fzf-lua = {
          enable = true;
          keymaps = {
            "<leader>ff" = {
              action = "files";
              options = {
                desc = "Find Files";
                silent = true;
              };
              settings = {
                previewers = {
                  bat = {
                    cmd = "bat --color=always {}";
                  };
                };
                winopts = {
                  height = 0.8;
                };
              };
            };
            "<leader>fg" = {
              action = "live_grep";
              options = {
                desc = "Live Grep";
                silent = true;
              };
              settings = {
                previewers = {
                  bat = {
                    cmd = "bat --color=always {}";
                  };
                };
                winopts = {
                  height = 0.8;
                };
              };
            };
            "<leader>fb" = {
              action = "buffers";
              options = {
                desc = "Find Buffers";
                silent = true;
              };
              settings = {
                previewers = {
                  bat = {
                    cmd = "bat --color=always {}";
                  };
                };
                winopts = {
                  height = 0.8;
                };
              };
            };
            "<leader>h" = {
              action = "helptags";
              options = {
                desc = "Help Tags";
                silent = true;
              };
              settings = {
                previewers = {
                  bat = {
                    cmd = "bat --color=always {}";
                  };
                };
                winopts = {
                  height = 0.8;
                };
              };
            };
            "<leader>c" = {
              action = "command_history";
              options = {
                desc = "Command History";
                silent = true;
              };
              settings = {
                previewers = {
                  bat = {
                    cmd = "bat --color=always {}";
                  };
                };
                winopts = {
                  height = 0.8;
                };
              };
            };
          };
        };
      };
    }
  ]);
}
