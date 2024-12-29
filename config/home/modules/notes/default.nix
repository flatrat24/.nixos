{ lib, config, ... }: {
  options = {
    notes = {
      enable = lib.mkEnableOption "enables notes";
    };
  };

  config = lib.mkIf config.notes.enable (lib.mkMerge [
    (lib.mkIf config.hyprland.enable {
      wayland.windowManager.hyprland.settings = {
        bindd = [
          "$mod, n, Open Notes, exec, foot --title=NOTES -e nvim -c 'set wrap nonu' ~/.notes/main.md"
        ];
        windowrulev2 = [
          "float,title:NOTES"
          "size 30% 80%,title:NOTES"
          "center 1,title:NOTES"
        ];
      };
    })
  ]);
}
