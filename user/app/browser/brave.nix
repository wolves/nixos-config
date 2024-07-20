{ config, pkgs, ...}:

{
  home.sessionVariables = {
    DEFAULT_BROWSER = "${pkgs.brave}/bin/brave";
  };

  xdg.mimeApps.defaultApplications = {
  "text/html" = "brave.desktop";
  "x-scheme-handler/http" = "brave.desktop";
  "x-scheme-handler/https" = "brave.desktop";
  "x-scheme-handler/about" = "brave.desktop";
  "x-scheme-handler/unknown" = "brave.desktop";
  };
}
