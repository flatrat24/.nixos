{ pkgs, lib, inputs, config, ... }:
let
  profileName = "ea";
  dependencies = with pkgs; [
    firefox
  ];
  extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
    youtube-shorts-block
    ublock-origin
    sponsorblock
    keepassxc-browser
    browserpass # TODO: Implement this
    firefox-color # For textfox
  ];
in {
  # options = {
  #   firefox.enable = lib.mkEnableOption "enables firefox";
  # };

  # config = lib.mkIf config.firefox.enable [
    # inputs.textfox.homeManagerModules.default;
  # ];

  # config = lib.mkIf config.firefox.enable {
    home.packages = dependencies;

    textfox = {
      enable = true;
      profile = "${profileName}";
      config = {
        displayHorizontalTabs = false;
        displayNavButtons = true;
      };
    };

    programs.firefox = {
      enable = true;
      profiles = {
        "${profileName}" = {
          name = "Ethan Anthony";
          isDefault = true;
          
          extensions = extensions ++ [];

          search = {
            force = true;
            default = "Startpage";
            engines = {
              "Startpage" = {
                urls = [ { template = "https://www.startpage.com/rd/search?query={searchTerms}&language=auto"; } ];
                definedAliases = [ "@s" ];
              };
              "Nix Packages" = {
                urls = [{
                  template = "https://search.nixos.org/packages";
                  params = [
                    { name = "type"; value = "packages"; }
                    { name = "query"; value = "{searchTerms}"; }
                  ];
                }];
                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@np" ];
              };
              # "NixOS Wiki" = {
              #   urls = [{ template = "https://wiki.nixos.org/index.php?search={searchTerms}"; }];
              #   iconUpdateURL = "https://wiki.nixos.org/favicon.png";
              #   updateInterval = 24 * 60 * 60 * 1000; # every day
              #   definedAliases = [ "@nw" ];
              # };
              # "MyNixOS" = {
              #   urls = [{ template = "https://mynixos.com/search?q="; }];
              #   iconUpdateURL = "https://wiki.nixos.org/favicon.png";
              #   updateInterval = 24 * 60 * 60 * 1000; # every day
              #   definedAliases = [ "@nm" ];
              # };
            };
          };

          settings = {
            "browser.startup.homepage" = "about:home";

            # Disable irritating first-run stuff
            "browser.disableResetPrompt" = true;
            "browser.download.panel.shown" = true;
            "browser.feeds.showFirstRunUI" = false;
            "browser.messaging-system.whatsNewPanel.enabled" = false;
            "browser.rights.3.shown" = true;
            "browser.shell.checkDefaultBrowser" = false;
            "browser.shell.defaultBrowserCheckCount" = 1;
            "browser.startup.homepage_override.mstone" = "ignore";
            "browser.uitour.enabled" = false;
            "startup.homepage_override_url" = "";
            "trailhead.firstrun.didSeeAboutWelcome" = true;
            "browser.bookmarks.restore_default_bookmarks" = false;
            "browser.bookmarks.addedImportButton" = true;

            # UI Options
            "browser.compactmode.show" = true;
            "browser.uidensity" = 1;
            "browser.tabs.tabmanager.enabled" = false;
            "browser.fullscreen.autohide" = false;
            "browser.toolbars.bookmarks.visibility" = "never";
          "sidebar.position_start" = false;

            # Prevent window from closing when last tab is closed
            "browser.tabs.closeWindowWithLastTab" = false;

            # Remove unwanted features
            "extensions.pocket.enabled" = false; # pocket
            "identity.fxaccounts.enabled" = false; # firefox sync
            "browser.tabs.firefox-view" = false; # tab overview # TODO: Fix this
            "signon.rememberSignons" = false; # asking to save passwords

            # Prevent warning when opening about:config
            "browser.aboutConfig.showWarning" = false;
          };
        };
      };
    };

    xdg = {
      enable = true;
      mimeApps.enable = true;
      mimeApps.defaultApplications = {
        "text/html" = ["firefox.desktop"];
        "text/xml" = ["firefox.desktop"];
        "x-scheme-handler/http" = ["firefox.desktop"];
        "x-scheme-handler/https" = ["firefox.desktop"];
      };
    };
  # };
}
