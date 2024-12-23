{ pkgs, lib, config, ... }:
let
  dependencies = [
    courseInfo
    courseTools
  ];
  courseInfo = pkgs.writeShellApplication {
    name = "courseInfo";
    runtimeInputs = with pkgs; [
      jq
    ];
    text = builtins.readFile ./sources/courseInfo;
  };
  courseTools = pkgs.writeShellApplication {
    name = "courseTools";
    runtimeInputs = with pkgs; [
      jq
    ];
    text = builtins.readFile ./sources/courseTools;
  };
in {
  imports = [ ];

  options = {
    school = {
      enable = lib.mkEnableOption "enables school";
    };
  };

  config = lib.mkIf config.school.enable (lib.mkMerge [
    {
      home = {
        packages = dependencies;
        sessionVariables = {
          CURRENTCOURSE = /home/ea/Documents/School/currentcourse; # TODO: remove hardcoded ea user
          CURRENTQUARTER = /home/ea/Documents/School/currentquarter; # TODO: remove hardcoded ea user
        };
      };
    }
    (lib.mkIf config.yazi.enable {
      programs.yazi.keymap.manager.keymap = [
        { on = [ "g" "s" ]; run = "cd ~/Documents/School"; desc = "School"; }
      ];
    })
  ]);
}
