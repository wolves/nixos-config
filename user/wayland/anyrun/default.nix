{ config, pkgs, anyrun, ... }:

{
  programs.anyrun = {
    enable = true;

    config = {
      plugins = with anyrun.packages.${pkgs.system}; [
        applications
        # randr
        rink
        # shell
        # symbols
      ];

      width.fraction = 0.3;
      y.absolute = 180;

      hidePluginInfo = true;
      closeOnClick = true;
    };

    extraCss = builtins.readFile ./style.css;

    extraConfigFiles."applications.ron".text = ''
      Config(
        desktop_actions: false,
        max_entries: 5,
        terminal: Some("${pkgs.foot}/bin/footclient")
      )
    '';
  };
}
