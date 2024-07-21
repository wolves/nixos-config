{ config, pkgs, browser, ... }:
let
  webBrowser = "${browser}.desktop";
in {
  xdg.mimeApps = rec {
    enable = true;
    defaultApplications = {
      "text/html" = webBrowser;
      "x-scheme-handler/http" = webBrowser;
      "x-scheme-handler/https" = webBrowser;
      "x-scheme-handler/about" = webBrowser;
      "x-scheme-handler/unknown" = webBrowser;
    };
  };
}
