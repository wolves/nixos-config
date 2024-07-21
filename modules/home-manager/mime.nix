{ config, pkgs, browser, ... }:
let
  web-browser = "${browser}.desktop";
in {
  xdg.mimeApps = rec {
    enable = true;
    defaultApplications = {
      "text/html" = web-browser;
      "x-scheme-handler/http" = web-browser;
      "x-scheme-handler/https" = web-browser;
      "x-scheme-handler/about" = web-browser;
      "x-scheme-handler/unknown" = web-browser;
    };
  };
}
