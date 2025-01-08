{ pkgs, lib, config, ... }:
let
  cfg = config.school;
  dependencies = [
    courseInfo
    courseTools
    selectNewCourse
    openCourseBookmark

    # For VM (Solidworks)
    pkgs.libvirt-glib
  ];
  selectNewCourse = pkgs.writeShellApplication {
    name = "selectNewCourse.sh";
    runtimeInputs = [
      courseInfo
      courseTools
      pkgs.wofi
    ];
    text = builtins.readFile ./sources/selectNewCourse.sh;
  };
  openCourseBookmark = pkgs.writeShellApplication {
    name = "openCourseBookmark.sh";
    runtimeInputs = [
      courseInfo
      courseTools
      pkgs.wofi
    ];
    text = builtins.readFile ./sources/openCourseBookmark.sh;
  };
  courseInfo = pkgs.writeShellApplication {
    name = "courseInfo.sh";
    runtimeInputs = with pkgs; [
      jq
    ];
    text = builtins.readFile ./sources/courseInfo.sh;
  };
  courseTools = pkgs.writeShellApplication {
    name = "courseTools.sh";
    runtimeInputs = with pkgs; [
      jq
    ];
    text = builtins.readFile ./sources/courseTools.sh;
  };
in {
  imports = [ ];

  options = {
    school = {
      enable = lib.mkEnableOption "enables school";
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home = {
        packages = dependencies;
        sessionVariables = {
          CURRENTCOURSE = /home/ea/Documents/School/currentcourse; # TODO: remove hardcoded ea user
          CURRENTQUARTER = /home/ea/Documents/School/currentquarter; # TODO: remove hardcoded ea user
        };
      };
    }
    (lib.mkIf config.hyprland.enable {
      wayland.windowManager.hyprland.settings = {
        bindd = [
          "$mod, slash, Set Current Course, exec, selectNewCourse.sh"
          "$mod SHIFT, slash, Update Current Course, exec, courseTools.sh --auto-course"
          "$mod SHIFT CTRL, slash, Pull Current Quarter Git Repository, exec, cd $CURRENTQUARTER && git pull || notify-send 'Error' 'Unable to pull current quarter repository'"
          "$mod, period, Create Basic Figure, exec, courseTools.sh --create-basic-figure | wl-copy"
          "$mod SHIFT, period, Create Basic Lecture, exec, courseTools.sh --create-basic-lecture"
          "$mod, comma, Open Course Bookmark, exec, openCourseBookmark.sh"
          "$mod SHIFT, comma, Edit Current Lecture, exec, courseTools.sh --edit-current-lecture"
        ];
      };
    })
    (lib.mkIf config.yazi.enable {
      programs.yazi.keymap.manager.keymap = [
        { on = [ "g" "s" ]; run = "cd ~/Documents/School"; desc = "School"; }
      ];
    })
  ]);
}
