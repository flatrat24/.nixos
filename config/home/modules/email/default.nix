{ pkgs, lib, inputs, config, ... }:
let
  profileName = "ea";
  dependencies = with pkgs; [ ];
in {
  imports = [ ];

  options = {
    email = {
      enable = lib.mkEnableOption "enable email";
      thunderbird.enable = lib.mkEnableOption "enables thunderbird";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf (config.email.enable == true) {
      home.packages = dependencies;
    }
    (lib.mkIf (config.email.thunderbird.enable == true) { # TODO: Make it rely on both email and thunderbird options
      programs.thunderbird = {
        enable = true;
        settings = {};
        profiles = {
          DU = {
            name = "Ethan Anthony";
            isDefault = true;
            search = {
              force = true;
              default = "Startpage";
              privateDefault = "Startpage";
              order = [ "Startpage" ];
              engines = {
                "Startpage" = {
                  urls = [ { template = "https://www.startpage.com/rd/search?query={searchTerms}&language=auto"; } ];
                  definedAliases = [ "@s" ];
                };
              };
            };
          };
        };
      };
    }
  ];
}
