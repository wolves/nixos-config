{  config, pkgs, firefox-addons, system, ... }:

{

  programs.firefox = {
    enable = true;

    profiles = let
      extensions = with firefox-addons.packages.${system}; [
        bitwarden
        sidebery
        sponsorblock
        reduxdevtools
        ublock-origin
      ];
      settings = {
        "extensions.pocket.enabled" = false;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;

        # Prevent tabbing on the "3 dot menu" on Firefox Suggest drop down items
        # https://connect.mozilla.org/t5/discussions/how-to-remove-the-3-dot-menu-on-firefox-suggest-drop-down-items/td-p/28339
        "browser.urlbar.resultMenu.keyboardAccessible" = false;
      };

      userChrome = ''
        #main-window #TabsToolbar {
          height 45px !important;
          overflow: hidden;
          transition: height .3s .3s !important;
        }

        #main-window[titlepreface*="wlvs"] #titlebar {
          height: 0 !important;
          min-height: 0px !important;
        }
        
        #main-window[titlepreface*="wlvs"] #TabsToolbar {
          height: 0 !important;
          min-height: 0px !important;
        }
        
        #main-window[titlepreface*="wlvs"] #tabbrowser-tabs {
          z-index: 0 !important;
        }
        
        #main-window[titlepreface*="wlvs"] hbox.titlebar-buttonbox-container {
          visibility: hidden;
        }
      '';
    in {
      wlvs = {
        id = 0;
        isDefault = true;
        path = "wlvs";
        inherit
          extensions
          settings
          userChrome
          ;
      };
    };
  };
}
