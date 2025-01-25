{ lib, config, ... }:
let
  cfg = config.notes;
in {
  options = {
    notes = {
      enable = lib.mkEnableOption "enables notes";
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    (lib.mkIf config.hyprland.enable {
      wayland.windowManager.hyprland.settings = {
        bindd = [
          "$mod, n, Open Notes, exec, foot --title=NOTES -e nvim -c 'set wrap nonu' -c 'IBLDisable' -c 'Gitsigns detach' ~/.notes/main.md && cd ~/.notes && git add . && git commit -m 'notes' && git push && cd"
          "$mod SHIFT CTRL, n, Pull Notes Git Repository, exec, cd ~/.notes && git pull && cd || notify-send 'Error' 'Unable to pull .notes repository'"
        ];
        windowrulev2 = [
          "float,title:NOTES"
          "size 40% 80%,title:NOTES"
          "center 1,title:NOTES"
        ];
      };
    })
  ]);
}
